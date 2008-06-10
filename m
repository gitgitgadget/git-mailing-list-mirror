From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 12:33:25 +0200
Message-ID: <bd6139dc0806100333s4395cca4g52b58679d7fc5c25@mail.gmail.com>
References: <484D78BF.6030504@gmail.com>
	 <20080610063328.GB26965@diana.vm.bytemark.co.uk>
	 <alpine.DEB.1.10.0806092335420.17180@swallowtail>
	 <bd6139dc0806100107y415a292eqe22af7a7b2215e65@mail.gmail.com>
	 <20080610095349.GA30119@diana.vm.bytemark.co.uk>
	 <bd6139dc0806100257k4700d364occ08457279e8a735@mail.gmail.com>
	 <20080610102800.GB30119@diana.vm.bytemark.co.uk>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Asheesh Laroia" <asheesh@asheesh.org>,
	"Clark Williams" <clark.williams@gmail.com>,
	"Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 12:34:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K61BF-00073P-6p
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 12:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYFJKd1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 06:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbYFJKd1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 06:33:27 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:23844 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYFJKd0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 06:33:26 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2534433wfd.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=R2lZm/1HhAetU7ID7HjWP7xThn8jcXFVsQErWCdfstY=;
        b=Ggv8rSBUN0ufB2nZc8lm1aw4IO04fUikpapN29wlbBGoraNYUcF+YUTNIdH/k4Iwib
         naO18Qlj7KjT7sGPSJ6lKKXQvnZSyjikrfcqRIan2z1u7JuA7SbLHRVoT0afVGzU0LtV
         /Ep6HHUaKRrd6LH8Pc0z+SgDTmtY8uUV3Wba4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Qx8nDaYVxYDDz0Gsgwz+YSWyPA9zR+jqN0BMpte/5OP38LA8JrSALfkZ5ueZF97+2U
         rHR/GC5cl4uZpyXyjg6H9OzPvd3c4Sv31a6TIBv+/vphzOrYJsgdrtacsJ0FvLN7Mrdq
         rHwjE+YzUK+tY51H609edGrhmHpvZbir3fgjA=
Received: by 10.142.12.18 with SMTP id 18mr1961562wfl.304.1213094005528;
        Tue, 10 Jun 2008 03:33:25 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 10 Jun 2008 03:33:25 -0700 (PDT)
In-Reply-To: <20080610102800.GB30119@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84493>

On Tue, Jun 10, 2008 at 12:28 PM, Karl Hasselstr=F6m <kha@treskal.com> =
wrote:
> If there's just one patch in the tar file, why did you use a tar file
> in the first place instead of just gzipping?

I guess mostly habbit :P. Whenever I zip something I create a gzipped
tarball because that's how I usually do it.

> I'm pretty sure that anyone who really has use for the tar-file
> capability would be using tar files with multiple patches in them.

Yeah, I guess that's true for most people indeed.

> I was refering to the fact that due to tar-files in the general case
> containing more than one patch, you'd have to modify the parts of
> imprt.py that deal with importing multiple patches at once, in
> addition to the parts the current patch touches.

Mhhh, yeah, but should be something like
for patch in patches
  applyPatch(patch)

> But you're probably right that the amount of additional work would no=
t
> be much more than what went into the current patch.

To just support .tar, yeah, but let's see what the author has to say
about this ;).

--=20
Cheers,

Sverre Rabbelier
