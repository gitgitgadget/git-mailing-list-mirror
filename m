From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2] Document RUN_SETUP_GENTLY
Date: Tue, 29 Apr 2014 15:21:34 -0400
Message-ID: <CAE+yK_kwMWRBDEVO=WVh5H-uFQJa2LEezRwbKnduLqoFjWC4zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 21:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfDb1-0000s2-V6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 21:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478AbaD2TVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 15:21:36 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:33144 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759AbaD2TVf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 15:21:35 -0400
Received: by mail-we0-f180.google.com with SMTP id t61so682551wes.11
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 12:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=+uF876xUvSLaVO3aI/+YUW7r7jroFKP0ixdXNSi6uMc=;
        b=i9MmI9VbPBJ/JoPszeZv8d/49HoMUhSJvMFBbGuAVaDl9cQPJV3lVbkewv6BYdJA3I
         84VonKZdpuBNyQMrW6AApLoSIPgBfS0lxGQeND8zuKK1XzQp55dsnbirtZLcRlo2nQKJ
         J9bsGXhsAykPuuIxs5rGHo7HgChq+DiHqzfeYmwiHgXKgGqhZ/7KchYre3hVFW+O0iGV
         jWc1k3o9FKfP1PIhdf8furhp3WLLLJhMJmSyimbLbEpYZcSOVpsu2CwjqFKzMP0BK675
         dZqe0XO31Q7/nFnAEGcMNJBNFHZSjq9FVwk1+EWC5euvgNOUG7ZWlpWc6euLBPKDa9VS
         4NoQ==
X-Gm-Message-State: ALoCoQk5/c62winZcVM8kQA6oljoQCmWznoRe3OrsJCN8egEt5SNYccUxS02eTXRUdk+w1sQ5bwf
X-Received: by 10.194.89.168 with SMTP id bp8mr960140wjb.73.1398799294097;
 Tue, 29 Apr 2014 12:21:34 -0700 (PDT)
Received: by 10.180.18.104 with HTTP; Tue, 29 Apr 2014 12:21:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247606>

Sorry about that -- the documentation of RUN_SETUP confused me.  So I
have a new patch that edits that as well.

--
RUN_SETUP_GENTLY and improve RUN_SETUP docs

Signed-off-by: David Turner <dturner@twitter.com>
---
 Documentation/technical/api-builtin.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-builtin.txt
b/Documentation/technical/api-builtin.txt
index e3d6e7a..b250c1a 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -23,10 +23,15 @@ where options is the bitwise-or of:

 `RUN_SETUP`::

- Make sure there is a Git directory to work on, and if there is a
- work tree, chdir to the top of it if the command was invoked
- in a subdirectory.  If there is no work tree, no chdir() is
- done.
+ If there is not a Git directory to work on, abort.  If there
+ is a work tree, chdir to the top of it if the command was
+ invoked in a subdirectory.  If there is no work tree, no
+ chdir() is done.
+
+`RUN_SETUP_GENTLY`::
+
+ If there is a Git directory, chdir as per RUN_SETUP, otherwise,
+ don't chdir anywhere.

 `USE_PAGER`::

-- 


On Tue, Apr 29, 2014 at 2:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Turner <dturner@twopensource.com> writes:
>
>> Document RUN_SETUP_GENTLY
>>
>> Signed-off-by: David Turner <dturner@twitter.com>
>> ---
>>  Documentation/technical/api-builtin.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/technical/api-builtin.txt
>> b/Documentation/technical/api-builtin.txt
>> index e3d6e7a..1bbeda2 100644
>> --- a/Documentation/technical/api-builtin.txt
>> +++ b/Documentation/technical/api-builtin.txt
>> @@ -28,6 +28,11 @@ where options is the bitwise-or of:
>>   in a subdirectory.  If there is no work tree, no chdir() is
>>   done.
>>
>> +`RUN_SETUP_GENTLY`::
>> +
>> + If there is a Git directory, chdir as per RUN_SETUP, otherwise,
>> + don't create one and don't chdir.
>
> I can understand "don't chdir" part, but where does "don't create"
> come from?  Makes it sound as if non GENTLY version would create one
> if there isn't there, but I am guessing that that is not what you
> meant to say.
>
> Puzzled.
>
