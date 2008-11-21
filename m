From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] Check for help invocation before setup
Date: Fri, 21 Nov 2008 10:19:01 +0100
Message-ID: <36ca99e90811210119s215513a8m7c12c8d55fd54d70@mail.gmail.com>
References: <1227110623-4474-1-git-send-email-madduck@debian.org>
	 <1227110623-4474-2-git-send-email-madduck@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@debian.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 10:20:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3SBg-0003Sr-0w
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 10:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbYKUJTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 04:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbYKUJTH
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 04:19:07 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:40845 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbYKUJTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 04:19:05 -0500
Received: by gxk4 with SMTP id 4so749836gxk.13
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 01:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jSQC2zwhJCBl/FpdVA1LtZTeymNK3i+C3W/IvEYEvZg=;
        b=WFMh/zujaLvZOf0XZ6vskh3wp4kKT5e8vwvS40qZqJy/BChwX9FW/v65ixp/Uepd+j
         RTxHZr/cdTDTJW9J+fFWSc8VBTYrpI3InXZ1T3qcySHsBUXIh8kqoTIvyTfyPSKiOYPC
         dIel7OQfO+LDBybBgJ2mH7Dw8jXC7G1OpN0QA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SS5P3JVdlBFHJ6/vnHmd9zuMF3clHVgNEqZOFcGcPnNBCudOHsN2ltMAjfApjTSPMk
         +AE7IIzO4sFQqHuCFgqp11m9zqRQhPQM4/Cn9h3IvCwY3kbMNVH8Uiuf8t6oH/ym2EXl
         VLv8hQol1k7qAGY9qg7AWwBMWnz9yA/dgstWw=
Received: by 10.64.249.6 with SMTP id w6mr251972qbh.16.1227259141032;
        Fri, 21 Nov 2008 01:19:01 -0800 (PST)
Received: by 10.65.148.5 with HTTP; Fri, 21 Nov 2008 01:19:01 -0800 (PST)
In-Reply-To: <1227110623-4474-2-git-send-email-madduck@debian.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101503>

Hi,

On Wed, Nov 19, 2008 at 17:03, martin f. krafft <madduck@debian.org> wrote:
> The user ought to be able to call `tg help` from anywhere in the
> filesystem, not just Git repositories, so the help parsing has to happen
> before the calls to git git binary.
>
> Debian bug: #501982
I really second this. Plus, I think its crucial to check that we are
not inside the .git directory before setting up topgit. Because git
rev-parse --git-dir only works in the top .git dir, not deeper (i.e.
inside .git/refs) and will always return ".".

	$(git rev-parse --is-inside-work-tree) ||
		die "Not in a git working directory"

Bert
