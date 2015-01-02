From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: xfuncname problems with C++
Date: Fri, 2 Jan 2015 10:49:12 -0600
Message-ID: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 17:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y75Pb-0005El-7X
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 17:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbbABQtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 11:49:14 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:58349 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbABQtN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 11:49:13 -0500
Received: by mail-la0-f54.google.com with SMTP id pv20so15749340lab.13
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 08:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=JvBDofeKbskO2u1o9Y2wftuF1mFl20hYwCkbVCqgRm0=;
        b=SCmDFJDz6OkZAQWpvExaV+cFkh/pP1fk1u5SE9e5LirjHt/FC5TAn/RLVbNfIpKf4I
         lGytEcllj+uhU0mmGXJVwP5kbC9m/jd16COdCXrIZJ3Tq1507lwLNii3uyk+0GvTMUaE
         dfwHnmVQbiopgzqZjxHa5eYaO97hCdwVSc/lMapgQzAJVvNV7S632FuxkhKvUJWPA4o/
         thG7CyfVWSDzyrGLhwSwUxzoCyNZi/RdTSA2Xd4J7Mg5IfKCKrH2LlS7rNrS74jcYVdA
         FN+ak9rYFqtjh2nc3XEZNEaGw2aehri0zxoiDVDcYZMeOAAGtV1pVLsnlGtE55i0dND2
         QtvA==
X-Received: by 10.153.11.170 with SMTP id ej10mr77320093lad.24.1420217352246;
 Fri, 02 Jan 2015 08:49:12 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.114.185.67 with HTTP; Fri, 2 Jan 2015 08:49:12 -0800 (PST)
X-Google-Sender-Auth: -OKSiUUnaxe6yCUenQkAwHC2BbU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261977>

I have a function like so:

void MyClass::SomeFunction(int someParameter)
{
    // Stuff changed in here
}

When I do `git diff` on the file containing this function, I get a
chunk showing some changed code in this function somewhere in the
middle of the body. However, the chunk header shows my root namespace
name in the file instead of the function header:

@@ -144,15 +149,22 @@ namespace Utils

What I expect to see:

@@ -144,15 +149,22 @@ void MyClass::SomeFunction(int someParameter)

I've tried various regular expressions that work in regex testers I
use against this function signature, however they do not work when I
apply them to my config:

[diff "cpp"]
    xfuncname =
"^\\s*[\\w_][\\w\\d_]*\\s*.*\\s*[\\w_][\\w\\d_]*\\s*\\(.*\\)\\s*$"

File name is "foo.cpp", I even added it to my git attributes file:

*.cpp diff=cpp

Using the regex above, my chunk headers come back blank. Why is it
showing namespace? How do I make this match the nearest function
header?
