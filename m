From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 1/7] Make it possible to get sha1 for a path from the index
Date: Tue, 29 Mar 2016 20:28:29 +0700
Message-ID: <CACsJy8A-nwv2B=6B4TqAz+i=DxC6Wu5yO924uaXWd5zLuXFRTQ@mail.gmail.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com> <1459257930-17193-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 15:29:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akthk-00047I-Ra
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbcC2N3D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 09:29:03 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33611 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbcC2N3B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 09:29:01 -0400
Received: by mail-lb0-f169.google.com with SMTP id u8so10408672lbk.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UiwVlmD4sreRSWjmfx4yQ78UFIyPdnOcD1gDHs9ut2M=;
        b=GxBd81AgHlnKad14/oEC4BtG/2nSmI+47gGccXnvCGubxJbyEHDkjaHd3+JjnXld8G
         0BIaWx5BNeDCAl2XfmPaI7ZSGJYpKc+0w/ReERVKOki2L2K2G2dKoI04GEUkU5Df2F2z
         fQGEs6uClWCoIrV8kAmpfSh2LCldFqz/9X/L/S1e/5iAbfxhvjRoECjNqf4RBKDYz5tl
         EcKSWp/LOcraiXdFceuWMfMRMYIDSZr5N5djTIOz3ON1Z2jQNEO+cipzAu+zOJCSZrAJ
         PIqTOXZPN3mct/2RG7yHfsUdbbbR7CoKhrtMt1h+/oSabJsKZUb4JWVuuq6WLDi/wJer
         MYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UiwVlmD4sreRSWjmfx4yQ78UFIyPdnOcD1gDHs9ut2M=;
        b=NL28+qZK5qbnYs5JsUCZKhsj0jI9tUS0tE2FPZc/QJ7qeU3b+vz11xf2e2Zb9q2L1c
         QN0xzamTiz/j3+3XEXmMcOnS5XPYE2B3j8W+rP8HLG56Uf7pYhMnLCkCiFSiMUjdNxRS
         gJQA6/rt7VcNFhbBYG+XltJdkf4Ji1KIx9OWiorRpjDGfki94HFJMa3fSu5CCMMR2e/X
         s9q2z8uuVQ0ucSgIVPEXTW8KbceHHz0bH+Q8tpFWsz54npcTVckGmo5sjtqPVGlMKDNr
         A8hmnQvFpae4rby0bURWYCMWDZCCBi8/Wlq20+xwncRrrm4qjE5xR3VY+ZUTyeYOXmnI
         HNSQ==
X-Gm-Message-State: AD7BkJJ4gv9FaTC93tu3QRPr4n+pYYqTC574LYpU0+wKXFA1QZtgP3dAzkfH+KCNJ9rXMr+3yR7OTlTX9unAjQ==
X-Received: by 10.112.157.105 with SMTP id wl9mr1136197lbb.137.1459258139450;
 Tue, 29 Mar 2016 06:28:59 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 29 Mar 2016 06:28:29 -0700 (PDT)
In-Reply-To: <1459257930-17193-1-git-send-email-tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290133>

On Tue, Mar 29, 2016 at 8:25 PM,  <tboegi@web.de> wrote:
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Factor out the retrival of the sha1 for a given path in
> read_blob_data_from_index() into the function get_sha1_from_index().

Getting _sha1_ from index is one function call and a memory
dereference or two. I think you mean get sha1 _file_ (or data) from
index. Maybe put either word in the function name.

> This will be used in the next commit, when convert.c can do the analy=
ze
> for "text=3Dauto" without slurping the whole blob into memory at once=
=2E
--=20
Duy
