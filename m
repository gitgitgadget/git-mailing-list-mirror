From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit - continue rebase after merge conflict?
Date: Thu, 28 Feb 2008 21:50:04 +0000
Message-ID: <b0943d9e0802281350r3945d3f0qd0dd8ee61679e82d@mail.gmail.com>
References: <20080226145725.GA24987@ldl.fc.hp.com>
	 <b0943d9e0802260856j6e9b0053ne4916149d8e4387c@mail.gmail.com>
	 <20080228173830.GA16045@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Alex Chiang" <achiang@hp.com>,
	"Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 22:50:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUqeM-00026W-10
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYB1VuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYB1VuJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:50:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:35822 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYB1VuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:50:07 -0500
Received: by wr-out-0506.google.com with SMTP id c48so5432560wra.23
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 13:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Tz8K+9YCqVkuJm5JiEPLGZyjst2TAkj3Tp1LvFjORm8=;
        b=echIC1PYBZ3lt0C3gZmK1kfg3cKEJaoLYurGqcrgKssRhygJiGvRaiVlLVCUtHM+r36Y38oyysfWDm7TMfPfoU1GFEGsMxiIztOJsOWDEu8pzUnOHNUKBLTNwRPNNvPgXW6acp8YuZhzqMaCsOQGfI8El19tMT/NT6X2gPfQpqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PxJNdho0dUW6Tz27R3NJLXnca2Zp+Fvbj9bgAshIQUwgngaNr8TuUaOBWVhpm1YEDNQTVOLdN5CikJtEbtRL6mxFC8uzkKz1nbi0LqloRuqkIc2WgyCKnfj+9hw+v3JKZcnpIhdZ7l2VZbXBzzCilG/X1onAw2x7E1dgG52Hfoo=
Received: by 10.141.205.10 with SMTP id h10mr5932709rvq.138.1204235404655;
        Thu, 28 Feb 2008 13:50:04 -0800 (PST)
Received: by 10.141.206.19 with HTTP; Thu, 28 Feb 2008 13:50:04 -0800 (PST)
In-Reply-To: <20080228173830.GA16045@ldl.fc.hp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75465>

On 28/02/2008, Alex Chiang <achiang@hp.com> wrote:
> * Catalin Marinas <catalin.marinas@gmail.com>:
>
> > On 26/02/2008, Alex Chiang <achiang@hp.com> wrote:
>  > >  How does one do a stg rebase if there are merge conflicts?
>  >
>  > Basically, you solve the conflict, refresh the current patch and
>  > continue with 'stg push' or 'stg goto <top patch>'. The 'rebase'
>  > command does 'pop --all', 'git reset', 'push --all'. In your conflict,
>  > the base of the stack was already changed to the latest and hence only
>  > push/goto is needed. To fix it:
>  >
>  > $ vi files   # or simply use 'resolved -i' below
>  > $ stg resolved -a [-i]
>  > $ stg refresh
>  > $ stg goto top-patch
>
>
> That goto command doesn't tell you about merge conflicts:
[...]
>  achiang@blender:~/kernels/linux-2.6$ stg goto 0004-ACPI-PCI-slot-detection-driver.patch
>  Pushed 0003-Introduce-pci_slot.patch (conflict)
>  Error: Merge conflict
>  Now at patch "0003-Introduce-pci_slot.patch"

It says that it's a merge conflict but isn't more precise than that.
You can run 'stg status' to check the conflicts.

The reason is that you are probably using the development branch of
StGIT and we (actually Karl) are refactoring the GIT objects handling.
The 'goto' command (but not 'push') was moved to the new
infrastructure but missed some of the UI stuff. They'll be added back.

I could use the stable branch until we sort out these issues.

-- 
Catalin
