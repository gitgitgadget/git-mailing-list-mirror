From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jn/shortlog (Re: What's cooking in git.git (May 2010, #01; Sun, 2))
Date: Mon, 3 May 2010 19:25:38 -0500
Message-ID: <20100504002526.GA7061@progeny.tock>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
 <1272912875.3537.6.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 02:25:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O95x8-0000Df-Qb
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 02:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993Ab0EDAZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 20:25:29 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:59207 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415Ab0EDAZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 20:25:28 -0400
Received: by yxe1 with SMTP id 1so692058yxe.33
        for <git@vger.kernel.org>; Mon, 03 May 2010 17:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZDlk1fluUFe9U4d+V5rt+TEi33daCTe1Gz4Y10rWysM=;
        b=B1uGYp9x0/fWa4DPw9n2xC5fsmXuV2rDkLTto9gkBcbaZrzsAOt0A5WOaDnzwzIhhz
         D2OSBnnO6XqpibMVzVfadb3px9w657N7GFJkQ6gM9fRgNSepANYgEjURfKDso4m1qF2m
         cRQFUoD1+9sIRraCJh6k1zLoeSLgjv8XCN5W8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jpEiNzKDwqR+wjFem4oa0ruZSg8lGiJaJO4EB1a0Ov0bynLFgSQXSzNl1LtHNgR1qj
         csZVG+5n0NpUh9jZRIQtUTdOx2G30ZcFwPW7EGnBobkeSrbNwS0W5D+g1PTcRwjEMyRE
         cE007idQRKrp8LLsCX5qN6CEKK63rUOFSIF9M=
Received: by 10.150.127.11 with SMTP id z11mr10241244ybc.20.1272932726848;
        Mon, 03 May 2010 17:25:26 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm155449iwn.5.2010.05.03.17.25.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 17:25:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272912875.3537.6.camel@dreddbeard>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146276>

Hi,

Will Palmer wrote:
> Junio C Hamano wrote:

>> * jn/shortlog (2010-04-26) 4 commits
>>  . pretty: Respect --abbrev option
>>  . shortlog: Document and test --format option
>>  . t4201 (shortlog): Test output format with multiple authors
>>  . t4201 (shortlog): guard setup with test_expect_success
>> 
>> This seems to cause intermittent test failure for me especially when run
>> under "make -j4".
>> 
>> * wp/pretty-enhancement (2010-04-30) 5 commits
[...]
> Does it still happen with the latest (3-commit) series?

I think it was the shortlog tests series[1].

> Haven't been able to reproduce here (just running make -m4 in a
> while-loop all night) Any specific tests failing?

In t4201-shortlog.sh:

--- expect.template     2010-05-04 00:17:41.609754167 +0000
+++ log.predictable     2010-05-04 00:17:41.613754428 +0000
@@ -1,10 +0,0 @@
-A U Thor (5):
-      SUBJECT
-      SUBJECT
-      SUBJECT
-      SUBJECT
-      SUBJECT
-
-Someone else (1):
-      SUBJECT
-

* FAIL 2: default output format

		git shortlog >log &&
		fuzz log >log.predictable &&
		test_cmp expect.template log.predictable

--- expect      2010-05-04 00:17:41.625754445 +0000
+++ log.predictable     2010-05-04 00:17:41.629754567 +0000
@@ -1,10 +0,0 @@
-A U Thor (5):
-      OBJECT_NAME
-      OBJECT_NAME
-      OBJECT_NAME
-      OBJECT_NAME
-      OBJECT_NAME
-
-Someone else (1):
-      OBJECT_NAME
-

* FAIL 3: pretty format

	sed s/SUBJECT/OBJID/ expect.template >expect &&
	git shortlog --format="%h" --abbrev=5 >log &&
	fuzz log >log.predictable &&
	test_cmp expect log.predictable

--- expect      2010-05-04 00:17:41.637754532 +0000
+++ log.predictable     2010-05-04 00:17:41.645754776 +0000
@@ -1,10 +0,0 @@
-A U Thor (5):
-      OBJID
-      OBJID
-      OBJID
-      OBJID
-      OBJID
-
-Someone else (1):
-      OBJID
-
* FAIL 4: --abbrev

		sed s/SUBJECT/OBJID/ expect.template >expect &&
		git shortlog --format="%h" --abbrev=5 >log &&
		fuzz log >log.predictable &&
		test_cmp expect log.predictable

--- expect      2010-05-04 00:17:41.657754653 +0000
+++ log.predictable     2010-05-04 00:17:41.661754495 +0000
@@ -1,10 +0,0 @@
-A U Thor (5):
-      two lines
-      two lines
-      two lines
-      two lines
-      two lines
-
-Someone else (1):
-      two lines
-

* FAIL 5: output from user-defined format is re-wrapped
        
		sed "s/SUBJECT/two lines/" expect.template >expect &&
		git shortlog --format="two%nlines" >log &&
		fuzz log >log.predictable &&
		test_cmp expect log.predictable

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/145769/focus=145801
