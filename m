From: Robert Buck <buck.robert.j@gmail.com>
Subject: newbie: should git bare repositories (forked ones) have an origin 
	defined?
Date: Wed, 5 May 2010 12:40:28 -0400
Message-ID: <q2r408104421005050940k2d054b20zad05552623ba2338@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 18:40:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9heK-0001oT-7O
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 18:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934252Ab0EEQka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 12:40:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59266 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933033Ab0EEQk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 12:40:29 -0400
Received: by wyb35 with SMTP id 35so486448wyb.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=7MIlLodJslZgpZJ+cMLZplKKE9+9SaPRLWKPwUtNXjI=;
        b=AQxA/itcokH6OCiXIh3CLKN4cSZxm5BBV2/Xl/Tk61KcdDwDj3cD15p4kBbLAJ/mCc
         uD8zVOnGsZdrnZLDsjevR9ZPDEXFFdZu/7xNSe4eJuyg2TwVWF4VLXtdukAgztRJMJcV
         wT64XYx7uOw7WWpMsXHdpOkYV3JOCEcXGRgjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=er/MOI9mSw19MYlk/ocnjDUMOC7UQHVZxyNeh5oZQkp5OUcAvtCFBN9di+6vkCvM25
         RzUt/zie0CgwuBjq4LLgr9+vapEyAZ4TqaFH74OxJ/Eu7j8RO1/oxfi08OCU5tSA0z76
         3PBtx8JthqS3G2e63D23YAVRohokNqtAyevKs=
Received: by 10.227.157.80 with SMTP id a16mr2868558wbx.185.1273077628138; 
	Wed, 05 May 2010 09:40:28 -0700 (PDT)
Received: by 10.216.25.18 with HTTP; Wed, 5 May 2010 09:40:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146409>

Yesterday I forwarded a question related to setting up public
repositories and flows. Related to that question, and central to one
point I do not understand, is not so much the role of origins, but
rather their application.

Given the following scenario, who defines origins, and where?

repositories : product.git, product-next.git,
product-story-or-module.git, product-maint.git

The idea here would be to have product-next.git and product-maint.git
repositories to be public repositories forked from product.git.

What I have read in the Oreilly Git book is that when you `init
--bare` there are no defined remotes, nor are there any branches. So
how specifically should these repositories be set up?

Here is a guess, but likely incorrect...

Master:

git init --bare product.git
git init product-init.git
cd product-init.git
git remote add origin ../product.git
touch README
echo "hello world" > README
git add README
git commit -m "initial checkin"
git push origin master

Next:

git clone --bare --no-checkout product.git product-next.git
cd product-next.git
git remote add upstream ../product.git

Comments:

When I create a local clone of "next" and inquire about remote refs,
there are none for "upstream". What I had thought was that by adding
in predefined remote refs into the forked repository itself that when
developers clone from it they would get those predefined refs for
free, so they could immediately make use of "upstream" in push/pull
operations.

Question:

Is what I am inquiring about reasonable, or is there a good reason to
not have remote refs embedded into the public forked repository?
How should public forked repositories ("next" in the use case above)
be initially created on its host?

Thank you,

Bob
