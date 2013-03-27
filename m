From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: More detailed error message for 403 forbidden.
Date: Wed, 27 Mar 2013 12:29:57 +0900
Message-ID: <CAFT+Tg_PwAS__AYCwQQZjy4LVvAMZFJuJ+ediDJpRnxx73qMMg@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 27 04:30:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKh4F-0005P8-CX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 04:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303Ab3C0D36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 23:29:58 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:46254 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247Ab3C0D35 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 23:29:57 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so7023200iag.27
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:reply-to:date:message-id:subject:from:to
         :content-type;
        bh=D8m8a/Tyy719Ww81AjOqwusQLwon+O0N3c7vLDDDNmo=;
        b=Dug/VPheed+prfZSzv5BpLQDF7zx7Wx5Z9LCpBIB65fLpCTzPATjVw6lmLa6rDF7J+
         h+hVVIZHGI59iCAc8kP7zVTED9HzgT1xz1RZbVLyYhBRemLAS4UL1AVjT4ul7eJSXcBZ
         EC25HcCu0wOFHgfPjIxJ8BrE5cgBhPPFQqiku5T1q89BVZnKGRpqIj8yEpIz6+Aee8hT
         htUYGu2JFNlLQDLOZeCt4uTwyZdcXfIKdpd+2LF5CLRTcF2PF8satqqFW2jvEsjG92aF
         KB7Ku4O03QSa3XdqIpZ0hDk8vS7wPCrJN5GMFM14Be18wCbRCeGQSMwZ+wYHZuR/uUX0
         lULQ==
X-Received: by 10.50.7.242 with SMTP id m18mr3142147iga.53.1364354997318; Tue,
 26 Mar 2013 20:29:57 -0700 (PDT)
Received: by 10.50.89.229 with HTTP; Tue, 26 Mar 2013 20:29:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219235>

Currently, if user tried to access a git repository via HTTP and it
fails because the user's permission is not enough to access the
repository, git client tells that http request failed and the error
was 403 forbidden.

But It is not enough for user to understand why it fails, especially
if the user don't know the username because git-credential-osxkeychain
authenticate implicitly without user knowing.

It would be much better if git client shows response body which might
include an explanation of the failure. For example,

before:

$ git clone http://localhost/foo/bar
error: The requested URL returned error: 403 while accessing
http://localhost/foo/bar
fatal: HTTP request failed

after:

$ git clone http://localhost/foo/bar
error: The requested URL returned error: 403 while accessing
http://localhost/foo/bar
remote: User 'me' does not have enough permission to access the repository.
fatal: HTTP request failed
