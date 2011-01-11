From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/3] Re: t4034: bulk verify builtin word regex sanity
Date: Tue, 11 Jan 2011 15:47:07 -0600
Message-ID: <20110111214707.GA29133@burratino>
References: <cover.1292688058.git.trast@student.ethz.ch>
 <854c8b6fa8a368bb34cc22d3fc948ae7136ed177.1292688058.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 11 22:47:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcm3v-0001va-Lw
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 22:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662Ab1AKVr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 16:47:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46808 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1AKVrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 16:47:25 -0500
Received: by fxm20 with SMTP id 20so20399399fxm.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 13:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PW7S5EA7K1nhi1JmAUdS2wkWV1UpbtXnl04vyhhLPRE=;
        b=AI2ERkwSNGV5abwLUID2Df2G+0FogzIPgldNwNx6kIQNJXSCC6g5HVpGSVudo8tmkD
         1f9mlYnfLrQkxQFg2lHvuncfQ3GXSlFvKfU+MS/jgovEEWjQXfZ8TbQXLXoDt3JJwPNM
         CSSP9gqIUuBfEiA6PZeNUIwdLZKkzZl25lYas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Dwa6dBWli4rJ5okOVHaBirIDHoWB61M7uWFqGGGyzxPimE3shNK+RaurS0RG5bbQcW
         ezRp8ppmwH77X3sXjbgQSgJoqVfYzM5qLpH/aMHTxUU3sCNNomRbnJoCD0ZZ4cowzM9A
         9LEQWNU4/r+pMS6hWtZ2eFEgpTwZdooLfR1eI=
Received: by 10.223.86.196 with SMTP id t4mr160597fal.34.1294782443374;
        Tue, 11 Jan 2011 13:47:23 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id f24sm7599049fak.24.2011.01.11.13.47.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 13:47:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <854c8b6fa8a368bb34cc22d3fc948ae7136ed177.1292688058.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164992>

Thomas Rast wrote:

> The builtin word regexes should be tested with some simple examples
> against simple issues, like failing to match a non-space character.
> Do this in bulk.

The above patch depends on "diff.c: implement a sanity check for word
regexes" but not in any essential way.  Patch 1 below is the part that
is still relevant without it.

Patch 2 changes the UTF-8 catchall to match a single non-ASCII
character[1], at the same time as making it harder to forget to use.
(My motivation is that the UTF-8 catchall is missing in the new perl
support.)

Patch 3 contains some cosmetic tweaks to the tests.  They were meant
as preparations for patch 2 but I checkened out and stopped there.

Thoughts and improvements welcome, as always.

Jonathan Nieder (2):
  userdiff: simplify word-diff safeguard
  t4034 (diff --word-diff): style suggestions

Thomas Rast (1):
  t4034: bulk verify builtin word regex sanity

 t/t4034-diff-words.sh  |  463 +++++++++++++++++++++++-------------------------
 t/t4034/bibtex/expect  |   15 ++
 t/t4034/bibtex/post    |   10 +
 t/t4034/bibtex/pre     |    9 +
 t/t4034/cpp/expect     |   36 ++++
 t/t4034/cpp/post       |   19 ++
 t/t4034/cpp/pre        |   19 ++
 t/t4034/csharp/expect  |   35 ++++
 t/t4034/csharp/post    |   18 ++
 t/t4034/csharp/pre     |   18 ++
 t/t4034/fortran/expect |   10 +
 t/t4034/fortran/post   |    5 +
 t/t4034/fortran/pre    |    5 +
 t/t4034/html/expect    |    8 +
 t/t4034/html/post      |    3 +
 t/t4034/html/pre       |    3 +
 t/t4034/java/expect    |   36 ++++
 t/t4034/java/post      |   19 ++
 t/t4034/java/pre       |   19 ++
 t/t4034/objc/expect    |   35 ++++
 t/t4034/objc/post      |   18 ++
 t/t4034/objc/pre       |   18 ++
 t/t4034/pascal/expect  |   35 ++++
 t/t4034/pascal/post    |   18 ++
 t/t4034/pascal/pre     |   18 ++
 t/t4034/php/expect     |   35 ++++
 t/t4034/php/post       |   18 ++
 t/t4034/php/pre        |   18 ++
 t/t4034/python/expect  |   34 ++++
 t/t4034/python/post    |   17 ++
 t/t4034/python/pre     |   17 ++
 t/t4034/ruby/expect    |   34 ++++
 t/t4034/ruby/post      |   17 ++
 t/t4034/ruby/pre       |   17 ++
 t/t4034/tex/expect     |    9 +
 t/t4034/tex/post       |    4 +
 t/t4034/tex/pre        |    4 +
 userdiff.c             |   37 ++---
 38 files changed, 887 insertions(+), 266 deletions(-)
 create mode 100644 t/t4034/bibtex/expect
 create mode 100644 t/t4034/bibtex/post
 create mode 100644 t/t4034/bibtex/pre
 create mode 100644 t/t4034/cpp/expect
 create mode 100644 t/t4034/cpp/post
 create mode 100644 t/t4034/cpp/pre
 create mode 100644 t/t4034/csharp/expect
 create mode 100644 t/t4034/csharp/post
 create mode 100644 t/t4034/csharp/pre
 create mode 100644 t/t4034/fortran/expect
 create mode 100644 t/t4034/fortran/post
 create mode 100644 t/t4034/fortran/pre
 create mode 100644 t/t4034/html/expect
 create mode 100644 t/t4034/html/post
 create mode 100644 t/t4034/html/pre
 create mode 100644 t/t4034/java/expect
 create mode 100644 t/t4034/java/post
 create mode 100644 t/t4034/java/pre
 create mode 100644 t/t4034/objc/expect
 create mode 100644 t/t4034/objc/post
 create mode 100644 t/t4034/objc/pre
 create mode 100644 t/t4034/pascal/expect
 create mode 100644 t/t4034/pascal/post
 create mode 100644 t/t4034/pascal/pre
 create mode 100644 t/t4034/php/expect
 create mode 100644 t/t4034/php/post
 create mode 100644 t/t4034/php/pre
 create mode 100644 t/t4034/python/expect
 create mode 100644 t/t4034/python/post
 create mode 100644 t/t4034/python/pre
 create mode 100644 t/t4034/ruby/expect
 create mode 100644 t/t4034/ruby/post
 create mode 100644 t/t4034/ruby/pre
 create mode 100644 t/t4034/tex/expect
 create mode 100644 t/t4034/tex/post
 create mode 100644 t/t4034/tex/pre

[1] suggested in <201012261206.11942.trast@student.ethz.ch>, which is
missing from gmane for some reason.
