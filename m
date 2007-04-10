From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH (resend)] Pass -C1 to git-apply in StGIT's apply_diff() and apply_patch().
Date: Tue, 10 Apr 2007 23:38:55 +0100
Message-ID: <b0943d9e0704101538p3de0bf56m7906cfe2f5fc157e@mail.gmail.com>
References: <20070409112422.GE11593@moonlight.home>
	 <b0943d9e0704100948k2b505916w5485b99e72d36c10@mail.gmail.com>
	 <20070410192130.GE4946@moonlight.home>
	 <20070410193214.GF4946@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOzY-0000uQ-9I
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030690AbXDJWi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030688AbXDJWi6
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:38:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:51748 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030653AbXDJWi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:38:56 -0400
Received: by ug-out-1314.google.com with SMTP id 44so166316uga
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 15:38:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CZdjSr7ZjGajEkxqM+V2f0qKm9AeRtvOSfafhJCiw4TbEoN1qWRymYAKYifsXkyIzr9osEMnlSeGNPNS9nJyi60r6bWwNKbHct4SD42GA2w2juiiQcM0iBJ29hvRsllAOEa3rwEd5HsCGoAU5r2bxsomBrffNxDzjC9N+IYhFRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sAMh09xWT47JcEYUAzPOS8lcWZzdJRyDQcb+0riqkBhkLSvbLMBi3IWx5ub0elVlvhP7ok0TLXPSUrwZ8dxXcIEPtgZVICyx6M78OhwFCA2LGOhKFOr+31hJuLn913M0jbnV6/npksE7XKBKk9gjlQOtBj0V8k9g5QMhian/cj0=
Received: by 10.67.101.10 with SMTP id d10mr601600ugm.1176244735064;
        Tue, 10 Apr 2007 15:38:55 -0700 (PDT)
Received: by 10.66.255.11 with HTTP; Tue, 10 Apr 2007 15:38:55 -0700 (PDT)
In-Reply-To: <20070410193214.GF4946@moonlight.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44187>

On 10/04/07, Tomash Brechko <tomash.brechko@gmail.com> wrote:
> Once we are talking about StGIT's push (push of
> the patch back to the stack), why would we want to start tree-way
> merge when the context has changed?  My point was exactly that since I
> want to keep my patches up-to-date with the main branch, I do rebase
> from time to time, and I'm not interested in doing the merge every
> time just because something has changed upstream in surrounding code.

When something has changed in the surrounding code (not touched by
your patch), the automatic three-way merge should, in general, be able
to solve the issue as it uses the ancestor information. Is the
automatic three-way merge failing as well in your case?

> The same goes for patches that were already applied upstream.
> Whatever the current context around the code of my applied patch is, I
> have to accept it, because the patch was applied.  I'm going to throw
> it away locally, but currently I have to do the merge first.

I think -C1 should be OK for merge detection (in most situations) and
importing patch files (via import, fold) but I personally don't like
it when rebasing a patch. I still prefer a more precise context
checking, rather than the fuzzy one similar to the "patch" tool (as
the line numbers are usually volatile).

I'm OK with the idea of this patch but I would prefer a config option
and/or command line option rather than hard-coding it for people with
different views. A command line option could make sense for commands
like import/fold and a config option for the rest.

Thanks.

-- 
Catalin
