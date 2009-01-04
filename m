From: demerphq <demerphq@gmail.com>
Subject: Re: git-branch --print-current
Date: Sun, 4 Jan 2009 13:49:11 +0100
Message-ID: <9b18b3110901040449x65c63d6fo3d9fec9ddd5670c@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	 <1a69a9d80901040021i1dae2c6j7337cf57eed6476a@mail.gmail.com>
	 <quack.20090104T0440.lthbpun1bxo@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Arnaud Lacombe" <lacombar@gmail.com>,
	"Git mailing list" <git@vger.kernel.org>
To: "Karl Chen" <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Sun Jan 04 13:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJSR9-00036F-9i
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 13:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbZADMtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 07:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbZADMtO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 07:49:14 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:17281 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbZADMtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 07:49:13 -0500
Received: by qw-out-2122.google.com with SMTP id 3so6017940qwe.37
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 04:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hA/r9ZZTQEfe8XR5Gt0AB6M5ASfzS6pdx++H+JIxDvo=;
        b=VlZqlA9gkMH6BeIHL+B/Ejo2eh/zFQOQsKaIRKS5qRT9IY6/cLHdifYcC0tQS9bWgK
         xnuVZxfxK2RGBFotsfpUID3RtUmTjxFV5JisGJQd3/Qbjcs2/3+swguRm5mspTqfP4Sm
         /+O2HFq6k02UX9QLVMv42QqFXVsK2q4kdaMJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Eo3HBQbVT8KNBY6Z82DhHyue0DFQrwVahxpMHudG9Ya/kVUADmAZD/I4RW9vcallsJ
         xUpQ82MaDAs6iJdJ41J+pc3xGbXhcHUeIXd11R8YQ6Ws5oFTEzXysz+8lquVTe+M86vW
         YGlz1zTl9ghJSCSZHueZYmYTp0h0oHljwBp10=
Received: by 10.214.12.19 with SMTP id 19mr15823888qal.102.1231073351611;
        Sun, 04 Jan 2009 04:49:11 -0800 (PST)
Received: by 10.214.241.2 with HTTP; Sun, 4 Jan 2009 04:49:11 -0800 (PST)
In-Reply-To: <quack.20090104T0440.lthbpun1bxo@roar.cs.berkeley.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104514>

2009/1/4 Karl Chen <quarl@cs.berkeley.edu>:
>>>>>> On 2009-01-04 00:21 PST, Arnaud Lacombe writes:
>
>    Arnaud> FWIW, I had this in a stalled modification in a tree,
>    Arnaud> it just add the '-c' (as "current") option to git
>    Arnaud> branch. Patch is mostly for the record :/
>
> Thanks, glad someone else wanted this too.  If we modified
> git-symbolic-ref it would probably be less code since it doesn't
> have to loop over all branches, though from a UI perspective I
> still prefer git-branch.  Anyway doesn't look like people like the
> idea so how about that git-rev-parse --symbolic-abbrev-name idea
> :)

FWIW: I like the idea. Ive always thought that a --current flag to git
branch was missing. IOW i should be able to do:

   branch=`git branch --current`

and get back a usable branch name. I dont think one should need to
rely on awk or sed or scripts to find this out, if only for
portability reasons.

>
>    Arnaud> The main trouble I have with pipe stuff is that it
>    Arnaud> forks a process for something that can be done
>    Arnaud> natively. Previously, I was using awk(1) to extract
>    Arnaud> the current branch:
>
>    Arnaud> $ git branch | awk '/^\*/ {print $2}'
>
> Yet another addition to the list of ways to pipeline it, this one
> probably the shortest :)

Unfortunately it doesnt work well when you arent on a branch:

  $ git branch | awk '/^\*/ {print $2}'
  (no

So far two apparently expert git people have given solutions to this
problem that don't elegantly handle the edge cases.

That seems to me to be a powerful argument that it is actually more
difficult to do than is being represented here on the list, and
deserves to be native level git functionality.

Cheers,
yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
