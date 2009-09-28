From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms 
	from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
Date: Mon, 28 Sep 2009 08:46:36 -0400
Message-ID: <2c6b72b30909280546l62a6ef9cm21112ca071cdef4c@mail.gmail.com>
References: <200909252333.56756.robin.rosenberg.lists@dewire.com> 
	<901099.90084.qm@web27801.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, spearce@spearce.org,
	Jason van Zyl <jvanzyl@sonatype.com>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Mon Sep 28 14:47:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsFe0-000382-Pe
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 14:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbZI1Mqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 08:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbZI1Mqx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 08:46:53 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:39308 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbZI1Mqw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 08:46:52 -0400
Received: by iwn8 with SMTP id 8so2545103iwn.33
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=gc99ZLbDLmt1wM3EEq/DfqnLkDcX2na3T5KMaDE12dE=;
        b=fc1wEtS9j3qh6gj2kEifuLsY1jTk6Je1qfAtcZcXiNF2tWJYn0j7WVS/eNlKzy7PwD
         oUGaIiO6rQRLTY9Qp0GyUJVltuAXKhPxfPJpMkYiGLAVAu53AL2wwKMhnZIjTKbdA1bC
         b3BhQca8/fvHd/8qjAWlho1XX1Ckb25TKWdcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=r7vAs1CqehJtV8I2jHfjD1ttnadpWPEMmowspJTc2gnmf/gdpcDN/JU74F7Eqk3N3q
         0GEPBXG/dQ1hOJ/kdWGlsLt9Xz//s31mfLRd3Up7/7iNOhjXaT1wx2nlU//3E8KvrGma
         a7rjE4tnIqk70GKg6lA+WPNkZR/ez8ZICoPlA=
Received: by 10.231.26.131 with SMTP id e3mr6126511ibc.0.1254142016193; Mon, 
	28 Sep 2009 05:46:56 -0700 (PDT)
In-Reply-To: <901099.90084.qm@web27801.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129257>

On Sat, Sep 26, 2009 at 15:50, Mark Struberg <struberg@yahoo.de> wrote:
> Hi Robin!
>
> a) Actually git-format-patch only created 0001-0009 so there is no 0/9.

For larger patch series, it is good practice (at least on git@vger) to
provide a "cover letter" (see git-format-patch --cover-letter) to give
reviewers of the patch series an idea of what code is touched and for
you to give additional information, such as the state of the patch
series.

> b) 2/9 is the actual directory structure moving. I received it, but since it is pretty large (330k already with -M -l0) it might got filtered out?
> If so then may I ask you to please fetch it from http://github.com/sonatype/JGit branch 'mavenize'? It has the same content I sent to the list.

Some general notes on the patch series. First, I am glad you posted it
to have something to discuss and as I have stated in a private mail I
am glad you are doing this. However, I also think it needs a lot more
polish before being integrated.

While I understand that you want to credit Jason for doing the initial
probe into fully mavenizing JGit, I now think it is wrong to base the
patch series on his patch. My first impression is that it actually
removes features (by not keeping the JGit specific settings), which
you then try to amend later in the patch series.

In terms of making the patch series more manageable for you, I think
the best approach is to start with the patches not relevant to the
mavenizing (renaming PathSuffixTestCase). After this comes patches
which only touch pom.xml files. For example, move
jgit-maven/jgit/pom.xml to the top-level pom.xml, extract relevant
pieces to org.spearce.jgit/pom.xml and org.spearce.jgit.test/pom.xml,
improving the pom.xml`s by adding checkstyle/<scm> integration, and
mavenizing org.spearce.jgit.pgm/. The final and most invasive parts
(renaming/(re)moving code/eclipse files etc) should come last!

Taking this approach Robin and Spearce can start integrating initial
patces and we can all start testing the "mavenization" sooner rather
than after deciding how to rename things and whether or not to remove
certain files.

The above is a proposal and if you and other agree that it is the
right approach _and_ you do not feel you have the time necessary to
realize it, I am willing to work on it.

-- 
Jonas Fonseca
