From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like write failures
Date: Mon, 4 Feb 2008 15:24:21 +0000
Message-ID: <e1dab3980802040724l5ef12528y69f1d572b7ac8d54@mail.gmail.com>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
	 <alpine.LSU.1.00.0802041512140.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "gi mailing list" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 16:26:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM3Cc-0000Gw-KY
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 16:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbYBDPZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 10:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbYBDPZG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 10:25:06 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:2242 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbYBDPZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 10:25:04 -0500
Received: by rn-out-0910.google.com with SMTP id i24so1817969rng.19
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 07:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CwvjjZEOB8S3O0G5szIpvMemtOepYgZBJI9TR5Eoanw=;
        b=hgRa7FutJ3PkASss3iDin06rZihQcMzEHf85H0KpVZ7lzXPA876PnrDxdVjZVmh5pjEopXcEpfh8ORMcWNrsTEpoAS354ghm6XQIGWqdZIiOuoyoOFSNF8uphxHD9ubgvj/FLH15tKjgilU0LtvCgidX99lCJFjpsBCJ6wanHJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iN5rQFSvQqrescEFMWRZc8tgtlpFRg2GhZjy8MN8mjGhNRa2Uxzy7s3c5TLKZqTAAdmZCCoen9ITW4u5I97UOIG6d/gLrXpqfXWvu4C00nY5kjvwl5J2NthaHQ+5ZhLq6uGrEotfITrtu9DujYh/b3AxFyzUzZmyNFde2uTFE7s=
Received: by 10.150.139.15 with SMTP id m15mr3001743ybd.99.1202138662007;
        Mon, 04 Feb 2008 07:24:22 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Mon, 4 Feb 2008 07:24:21 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802041512140.7372@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72516>

On Feb 4, 2008 3:16 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 4 Feb 2008, David Tweed wrote:
>
> > +                       if(c>0 && c<4096 && stat(name, &status) == 0
> > +                          && status.st_mtime < now - 600){
>
> Please have spaces after the "if" and before the "{" (just imitate the
> style of the rest of the file).
>
> Also, 10 minutes grace period for any ongoing fetch or repack seems a bit
> arbitrary.  Maybe default to 10 minutes, and introduce
> prune.packGracePeriod?

In response to this and to Nico's earlier mail, I _think_ the usage
with repack is completely safe. What I'm not sure about is that other
things like git-svn create temporary packs with usage/semantics I'm
not sure about. I'm happy to delete immediately if those who
understand the interactions in the whole of git say that's acceptable
when the user specifically calls git-prune.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
