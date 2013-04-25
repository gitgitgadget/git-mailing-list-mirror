From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 21:29:49 +0200
Message-ID: <5179842D.6060500@gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com> <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com> <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:30:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRrj-0000Yf-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798Ab3DYT3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:29:55 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52904 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932554Ab3DYT3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:29:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id e19so977116bku.19
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=W3dJmnmUrY6O8WU+v7vD9l4uwsqX+dRvX424/bls5yQ=;
        b=Ii2+M91cqThPuToEioir2kbCQ+5wOuPvRlZUsXV+LzPhc42VMt8S3nZh4tXJPVySfN
         7MOGDx9ZDK876aUBnZJMv4XOzXbFn88kXuXah0tQubgtyJvkRSi/+iGvV05D+qdzwE89
         sojswWwzYwHioBQ/T6e4nJUtAYv3a+aWzWbB39oLYRnxLbkIwgdDpXMTuIEm8KOJpWgF
         QDRJxgI1V9p9P/fMehJTk1vgzOjBr8xF3L1D55Nm/iPIs9ouP5ikq7k80tKZIqE0p4Oe
         qoZQyF3QTRkKHUnqwkRdjEDqkgaU8t5tvzxWdYm3B9BOqaUXQqowyGWMl98JsvVoc11m
         H87w==
X-Received: by 10.204.229.140 with SMTP id ji12mr17124014bkb.113.1366918193348;
        Thu, 25 Apr 2013 12:29:53 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id fe8sm2173367bkb.9.2013.04.25.12.29.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 12:29:52 -0700 (PDT)
In-Reply-To: <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222419>

On 04/25/2013 08:19 PM, Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
>> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
>> index aa7bc97..82bf7c7 100755
>> --- a/contrib/remote-helpers/git-remote-bzr
>> +++ b/contrib/remote-helpers/git-remote-bzr
>> @@ -94,7 +94,7 @@ class Marks:
>>          return self.last_mark
>>
>>      def is_marked(self, rev):
>> -        return self.marks.has_key(rev)
>> +        return rev in self.marks
> 
> Why?  Is the new form faster than the older one?
>
I think the has_key() method is "deprecated" in modern python,
and the 'key in dict' usage is more idiomatic.

>> @@ -224,7 +224,7 @@ def export_files(tree, files):
>>              else:
>>                  mode = '100644'
>>
>> -            # is the blog already exported?
>> +            # is the blob already exported?
> 
> What is this?  Whitespace?
>
Typofix: s/blog/blob/

>> @@ -521,7 +521,7 @@ def c_style_unescape(string):
>>      return string
>>
>>  def parse_commit(parser):
>> -    global marks, blob_marks, bmarks, parsed_refs
>> +    global marks, blob_marks, parsed_refs
> 
> How is this trivial?  You just removed one argument.
>
Maybe bmarks was no longer used there as a global variable
(left-over from previous patches?), so there is no longer any
need to declare it global.

>> @@ -555,7 +555,7 @@ def parse_commit(parser):
>>              mark = int(mark_ref[1:])
>>              f = { 'mode' : m, 'data' : blob_marks[mark] }
>>          elif parser.check('D'):
>> -            t, path = line.split(' ')
>> +            t, path = line.split(' ', 1)
> 
> How on earth is this trivial?  It changes the entire meaning!
>
Indeed, that should best go in a separate path with a proper
explanation in the commit message.

>> @@ -643,6 +643,7 @@ def do_export(parser):
>>                  wt = repo.bzrdir.open_workingtree()
>>                  wt.update()
>>          print "ok %s" % ref
>> +
> 
> Whitespace?
>
Isn't that obvious?

> I'm outraged by this.  What kind of changes are you pushing to
> remote-hg?  A "trivial cleanups" bundling miscellaneous changes, with
> no commit message?  Why don't you just squash everything into one
> "miscellaneous changes" patch?
>
I have no opinion on this, so I won't comment.

Regard,
  Stefano
