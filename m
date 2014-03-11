From: karthik nayak <karthik.188@gmail.com>
Subject: [GSOC] Git Configuration API improvements
Date: Tue, 11 Mar 2014 18:42:37 +0530
Message-ID: <CAOLa=ZSKDg9DKxTRMy4yWW7=ZHcudGmK4guYmaP2okxH8Q044Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, mhagger@alum.mit.edu,
	Matthieu.Moy@grenoble-inp.fr
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 14:13:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNMUV-0008AX-07
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 14:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbaCKNNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 09:13:01 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:56129 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbaCKNNA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 09:13:00 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so8796597pbc.13
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=2xtAvt49asr5DMNzUwvqb/d/ElY5FXGlZTFHKWquQsg=;
        b=OHCHmOEsy1iFDSo9/D+U5+ymz0r8txwYZ1tye2Qk51449gGozjTy7nuwtNnbZW9d4T
         HAmQIGMq0F1lJUPIQUhcZORTdj6BfvN8ACovdWcl9JjJlqcClVj4XTRg98TKjHaHzSGZ
         QjocafD+RAVxkSd/xOqXkmvnEWfICd2v06ntwYWVczA5TyklUqcpEX1bJMg29qWqQSq6
         13ofJbqB/zigeJGt3bzhWYzhu0sRna9ducNw1ErMBAQEBwgmN+3Ya3yTDSvVvfOB3/sj
         Ha+W9a9ESVSGUc5fx3S5vHBfFHDfGyKYJ8vOhVoFchZ5x4p8NaZmKrrp5m/fP7F3BAY/
         WiKA==
X-Received: by 10.66.66.66 with SMTP id d2mr47416596pat.80.1394543579082; Tue,
 11 Mar 2014 06:12:59 -0700 (PDT)
Received: by 10.68.189.2 with HTTP; Tue, 11 Mar 2014 06:12:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243864>

Hello to all,

I'm Karthik Nayak, a Computer Science student from Bangalore India. I
will be applying for GSOC 2014. This is my first time applying for
GSOC. I have been using Git for a long time now, so it would be an
ideal organisation for me to contribute to.
As suggested I completed the Micro Project under the guidance of Eric
Sunshine.[1]

I went through the Idea's page[2] and the mails corresponding to the
topic[3]. Currently we have multiple invocation of git_config() in an
individual invocation of git() which is not efficient. Also, it is
hard to implement new features, as mentioned -- such as allowing a
configuration to be unset.

The basic idea is to use a data structure to store the config, the
first time the git_config() is called. And refer to this each and
every time we invoke git_config() further. Jeff suggested [4] to use a
tree or a mapping of keys to values which are stored in a string. I
think that the idea of storing using the config as a tree data
structure would be really advantageous.

This would allow us to easily implement modifications later, and can
help to easily take care of duplicates being created on multiple usage
of config set and unset. As, whenever a node's children have been
deleted the node can also be automatically deleted. The tree can be a
struct with values, header link and link to other configs. This way we
can also create functions to work on the tree easily.

Would be great to hear your thoughts on this topic and also I plan to
start creating a proposal. Nice to have any suggestions or feedback of
any kind.

Thank you,
Karthik

[1] : http://article.gmane.org/gmane.comp.version-control.git/243695/match=karthik+188+gmail+com
[2] : http://git.github.io/SoC-2014-Ideas.html
[3] : http://article.gmane.org/gmane.comp.version-control.git/243500/match=git+configuration+caching
[4] : http://article.gmane.org/gmane.comp.version-control.git/243542
