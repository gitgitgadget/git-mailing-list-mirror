From: Uwe Sommerlatt <uwe.sommerlatt@gmail.com>
Subject: Bug? git push --recurse-submodules=on-demand is not truly recursive
Date: Tue, 24 Mar 2015 13:50:13 +0100
Message-ID: <CAGt=MzCkB66K9L6gahUTH3cWafW8psNQYw3d8UKFFy5C+MUZcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 13:51:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaOIM-00049z-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 13:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbbCXMuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 08:50:55 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34771 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbCXMuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 08:50:54 -0400
Received: by obbgg8 with SMTP id gg8so146168153obb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=d/9ePTOoo8lXXspFyEb30BOCsWKypEJhP3Ds6ZeQqTE=;
        b=VK++zomMBGdLfjYskmit8hUMmXGobWYkrmz0RGfee9gbXZfYuddD6c6R9GQAkt0jiB
         BdHZWv+E4KywK6ywyywONfnkgjKaEugCQjlN6ttsrqbGW4be8GsLpA8HgOHMvDKcLeLF
         mzxHfoxwPhAjsoSqdhxZ3RpmpZt2VB7NeHAYb6biQ6nwFpCvuXmiXbMF57YtjI2CnkH/
         iSY1VxvOzKNL/viVd34SsefhcMfpGpzlxTkKRjXVbMeqvFHbxsMn0U0i3lvMWv31EMJI
         IPTq+hYPeUVuS3LA+msTJPpIpR0ApjFdZXMO4RIXxd7JuX177ogJ/ixruKKZsdrPz8mU
         tzqw==
X-Received: by 10.202.206.85 with SMTP id e82mr2988767oig.112.1427201453759;
 Tue, 24 Mar 2015 05:50:53 -0700 (PDT)
Received: by 10.202.196.195 with HTTP; Tue, 24 Mar 2015 05:50:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266184>

I have the following project structure:

root-project
      |
      |-- A
      |   |
      |   |-- C
      |
      |-- B

A and B are submodules of the root-project. C is in turn a submodule
of project A. Suppose I have made changes to projects A,B and C and
commited these changes to the respective indices. After that I update
the references to A and B in the root-project and commit that change
as well. When I push the commit of the root-project with the option
--recurse-submodules=on-demand, git pushes the commits of projects A,
B and the root-project but silently ignores all unpublished commits of
project C. I end up publishing a project that no one can successfully
clone because of the dangling link to C. Is this the expected
behaviour or is this a bug?

I have written a small shell script that sets up the project structure
and executes the described scenario:
https://gist.github.com/usommerl/6e8defcba94bd4ba1438

git version 2.3.3

Uwe Sommerlatt
