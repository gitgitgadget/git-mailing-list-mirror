From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 01/25] path.c: make get_pathname() return strbuf
 instead of static buffer
Date: Sat, 1 Mar 2014 09:40:23 +0700
Message-ID: <CACsJy8AKu6UQURW-Zn=VE5WF3Yqfg329nsCoxiCt+nSJKfTW3g@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-2-git-send-email-pclouds@gmail.com> <xmqqk3cq7kgm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 03:41:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJZrH-00048q-FJ
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 03:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbaCACky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 21:40:54 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:50594 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbaCACky (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 21:40:54 -0500
Received: by mail-qg0-f47.google.com with SMTP id 63so4496544qgz.6
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 18:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TcY8kLyvyuT4snlpTLCuaN0epg7l+fLjLMQzRX2cDEc=;
        b=Ka+TLQ/StL84OvThDa+Jv4y9HDDZpuRiAy8IdsDm4p5oT+PY/IRbNRvWfETzMtwK/X
         KO9zgoorq7O5qaVV489hRN6vqIObYvoxxUBjOgDN6dwiBu+E0HyP+ok91cWSyfyBS8/f
         /GDy7NRJk80INwt4pBzk/ra9lsPUotvDRwnnV7caxgvoVL62CNWwxXQAusixn16o9+gG
         6S0t3E1jp5P+0ZNS73DuHwMhzdClP9RP+t0n8LpGFK8RZ4t3qQJOL5pBKSfRRYFoS7di
         7v+aeTqdvgf+5sqwipzKEghT+sfvZWOpOJ7DEQUeZQN2li3pdtKPqx4Cp9tJBDx6RWlH
         aNsA==
X-Received: by 10.224.138.10 with SMTP id y10mr8393387qat.17.1393641653239;
 Fri, 28 Feb 2014 18:40:53 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 18:40:23 -0800 (PST)
In-Reply-To: <xmqqk3cq7kgm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243036>

On Thu, Feb 20, 2014 at 6:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Is there a reason not to do just an equivalent of
>
>     #define git_pathdup mkpathdup
>
> and be done with it?  Am I missing something?
>

They have a subtle difference: mkpathdup() calls cleanup_path() while
git_pathdup() does not. Without auditing all call sites, we can't be
sure this difference is insignificant. So I keep both functions
separate for now.
-- 
Duy
