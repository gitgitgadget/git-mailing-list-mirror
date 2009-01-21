From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: cherry-pick/rebase question
Date: Wed, 21 Jan 2009 12:46:26 -0500
Message-ID: <76718490901210946v6494dd6ejca5a69e1d0d5cfa4@mail.gmail.com>
References: <76718490901210927m7fd3fbdey6ebd4cbfe44b1b71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 18:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPhBD-0007DX-Ej
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 18:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbZAURq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 12:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbZAURq1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 12:46:27 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:46630 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbZAURq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 12:46:26 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3709022rvb.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 09:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=JJPI5Yu+Z7APQCyFMoNLRPND04hT3bLh2W1DX1W+eCo=;
        b=mKbRMcFENfv8R1vXE+nPE0GN9S+W0WGZ1jJjXScRkzyFxp/HOZKR0qdYgnvPSg1B7r
         GOTMfq7HQT9xPhdTEHYOkb85F3M31wajI4uyUVaPCWVDojVeFjmrMGrqKKoiNmDUyE1o
         ONfgmsMtqoBoB/kRTfsXmVYr0eGDGuB6XsSkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=P1rRLwiGqsth8Ek1OlHIZYsBScCHMk/IS2S5qhZ19QzgMnJm+1ik0cHfEewLjc8VfK
         oXZaHlq32otEuhZVqFEycbv4YUtRH0Re0airrlxIAxkWnucPH3Grza2f/Coq6LMv2Ppv
         xB83+N3udtbAGKWkbfOf+5csqacRLYwky9QQo=
Received: by 10.141.203.7 with SMTP id f7mr464909rvq.125.1232559986121; Wed, 
	21 Jan 2009 09:46:26 -0800 (PST)
In-Reply-To: <76718490901210927m7fd3fbdey6ebd4cbfe44b1b71@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106633>

On Wed, Jan 21, 2009 at 12:27 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Say I have the following linear set of commits on master:
>
> A---B---C---D---E---F---G master
>
> And I realize that I've intermixed two topics such that I want to move
> commits B and E-G to their own branch. So my result should be:
>
> A---C'---D' master
>  \
>  B'---E'---F'---G' topic
>
> What's the best way to do it?
>
> I read the rebase and cherry-pick man pages, found myself confused,
> tried rebase a few different ways, failed, and ended up doing what I
> needed with format-patch and am. (Extract B-G with format-patch, reset
> master to A, create topic branch, apply B,E,F,G to topic with am,
> similarly apply C,D to master with am.)

Hmm, not sure why I didn't think of it earlier, but I guess the easiest way is:

(master)$ git co -b topic
(topic )$ git rebase -i A (remove C and D)
(topic )$ git co master
(master)$ git rebase -i A (remove B, E-G)

j.
