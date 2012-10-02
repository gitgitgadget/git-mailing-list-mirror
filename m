From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Tue, 2 Oct 2012 08:00:54 -0700
Message-ID: <CAJo=hJtUVLpQaiR==DGdpeH5V5DGh9eF-Ez+gMNNKOyp_HbwVg@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8AUdRyjSrAgM+ABzWet2NKz7N7M4re2QVoRPrrA=zfvvg@mail.gmail.com>
 <CAJo=hJsWczUqhvj6Kqsomeh9WxAAJO-Yc-=61k94jos6vVtEjQ@mail.gmail.com>
 <CACsJy8D5AXSWAdK7tgtXnE4Ro_+okaYM=zf9JnQfObkcx=FCOw@mail.gmail.com>
 <CAJo=hJs8TcU=Vvq4Re2aqTUrgRqiSyHs1rA+fPDHUkvrhwc3OA@mail.gmail.com> <CACsJy8Aikmf5vwNhLbELLKfyLLPTppWFvoqGOdSBZ2JoL1C_JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 17:02:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ3yQ-0002SZ-NT
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 17:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461Ab2JBPBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 11:01:16 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60577 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab2JBPBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 11:01:15 -0400
Received: by qchd3 with SMTP id d3so4652726qch.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pYmxyiK2rutY3blhQgwNHPGtsj3n/183GOe+4edPIUw=;
        b=XQNd+VBtj8UoamtJ+4Z1Dxv9PX7PcxfDmI7QEMOLxFcpTNH/rJPd06HxlWQI/dJ0Ov
         pwy9HRLMnE2WvjVlI4RiW7bN/7XqXdbsoGqjwxva5dkPGWl+K+ffjtnVJgGL68oZLlYn
         WQBLIC5Q0qNqK3XTOMvJ/34JFdPNqiZ/GQ+x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=pYmxyiK2rutY3blhQgwNHPGtsj3n/183GOe+4edPIUw=;
        b=U1TY5kYWVPdQoSgKmbikRJxVoalYQINiKqyBhckiIbt1kL5KFFFjoT+Mqqpr+Hj2ph
         Xadj/q6i6I2jD8E7jjzgSGrOh0KYFGfuNEPB3F3zqHdH7E7S8b3FtXLSEBGMJrAZOQVy
         bBTUCKw+uzlohB31Z16bCLKVAxG0Jk5nNNr2j/wyeOlsptPv+TnAojU+X/kusu+Jfv1s
         Z+7Vr2QSw6nO3YvVoJCEXsmdxYuHSiZLUM7RSxDtPXcEwIRKV1Te6ev1weoOTHL1Af5U
         6mfV+ouE3um4Vt9v2+gLNiuv5FEa/5fnJO9MbtOT0gogD/v4hu9Sv6Ls9pvA7y8BKMF5
         q+6Q==
Received: by 10.229.136.210 with SMTP id s18mr11902905qct.10.1349190074532;
 Tue, 02 Oct 2012 08:01:14 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Tue, 2 Oct 2012 08:00:54 -0700 (PDT)
In-Reply-To: <CACsJy8Aikmf5vwNhLbELLKfyLLPTppWFvoqGOdSBZ2JoL1C_JQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQn2RYPZ8d4ILNycr2l2Ay1vYbqk4Hhwc8BK3BxiATboDVGPGS5SyZp9GDWvihm3z+6xE8ma
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206800>

On Mon, Oct 1, 2012 at 5:48 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Probably off topic. Does saving a list of missing bases in the pack
> index help storing thin packs directly? I may be missing some points
> because I don't see why thin packs cannot be stored on disk in the
> first place.

Packs are supposed to be completely self contained. We require all
delta bases to be in the pack so that we can always recover the
objects stored within it, even if there is no other pack available.
This simplifies things like git gc such that they don't need to worry
about retaining delta bases for other packs, or avoiding delta chain
cycles between packs. I have managed to create a A->B->A delta chain
once that made the repository corrupt as soon as the last non-delta
copy of A as removed. Both A and B became unreadable as A needed B
which needed A which needed B... :-(

To keep things simple and easily verified as correct, we don't allow this.
