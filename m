From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git repo corruption
Date: Tue, 04 Jan 2011 15:42:40 -0600
Message-ID: <4D239450.2010509@gmail.com>
References: <AANLkTi=TSy1WQZARNQgGfPiV93hQ-xmCTip75JAixgDB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Levend Sayar <levendsayar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 22:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaEey-0007m4-Mx
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 22:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab1ADVnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 16:43:10 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:39105 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab1ADVnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 16:43:09 -0500
Received: by yib18 with SMTP id 18so3573293yib.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 13:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=5eybSxiptEvMtGoIWMiMDUuBgUuKQE46gmFpdFbc00A=;
        b=FMXSv1VyQfN15Zotey3msrsbJg9l5Ow/9bzRhQaJuXdRGI4E2rBPMCxwtI0YiBDvA5
         ktM0ti4BxVySWbqkRbDt8W9zUMkDigvHRsIfPK80av46bLMpqbAhotEIPsHuPcLjIH0Z
         kVBu9MP/uTPqbruh32131/6Ujq3mbKOOFXMM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=CsaTI/NiX7HmRgl9iBpVHF2s0wNP3lOeL9Om9pAfgvp1ssfE4WfaYowON0bbPRilvX
         7Wg5LcHvI4EhVd6AsutbUQTZhpOlriHBubukjm7rtRFKmAt0q+mRGJDrN/bptNV76Zdh
         dZ2DWnTVSDWeY/fNC/inOgTI9qDsIdICgIoSo=
Received: by 10.150.220.15 with SMTP id s15mr21274850ybg.138.1294177388458;
        Tue, 04 Jan 2011 13:43:08 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id v8sm10986477ybe.13.2011.01.04.13.43.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 13:43:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTi=TSy1WQZARNQgGfPiV93hQ-xmCTip75JAixgDB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164521>

On 1/4/2011 3:10 AM, Levend Sayar wrote:
> Hi, all.
>
> We have a repo on a corporate server. The sysadmin changed access
> rights of files on our repo by accedant.
> Some directories have 2750 acces rights before, but he changed as
>
> chmod -R 2770 *
>
> Now when you make git status, every file that is tracked by git is said as
>
> changed but not updated
>
> So is there a way to get this back to normal ?
>
> TIA
>
> _lvnd_
> (^_^)

I assume the correct permissions for your tracked files should be 2750? 
  If so, then here's what I would do:

1.  First make a copy of your repo and test these steps on the copy:

e.g.  bare repo:  cp -rvp repo.git repocopy.git
non-bare-repo:  cp -rvp worktree worktreecopy

2. Then cd to the parent of the objects dir in you git repo:

e.g.  bare repo:  cd repocopy.git
non-bare repo:  cd worktreecopy/.git

3.  Then change the permissions of your objects dir:

chmod -R 2750 objects

4.  Validate the results.  Your permissions should match again.

5.  If it worked, then do it on the real repo.


v/r,
Neal
