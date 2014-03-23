From: Ashwin Jha <ajha.dev@gmail.com>
Subject: Re: [PATCH] Modify fsck_commit. Replace memcmp by skip_prefix
Date: Sun, 23 Mar 2014 18:40:55 +0530
Message-ID: <532EDD5F.9020402@gmail.com>
References: <1395501132-12894-1-git-send-email-ajha.dev@gmail.com> <CAPig+cRL3zFWtBq_yJQqwGa7Wc6GsdBqA_jrGm8p5ZMJVmr-yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>, tanayabh@gmail.com
X-From: git-owner@vger.kernel.org Sun Mar 23 14:12:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRiCM-0007m1-BG
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 14:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbaCWNLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 09:11:46 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32928 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaCWNLp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 09:11:45 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so4335922pad.30
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MhRz0CM95ht3zf1Ty2/5mXD/2gilmUM463oys6exTrY=;
        b=jLa6xQWgmviBL0K3Nfa6qdtZdWxsjVOwAhYbgSyW6BDmoTjvkL8gQ2ZB/pMZglOgH3
         D4AV+6YKOLsLYMaZWdmAeC2TW8wJN9sua3t8O0+7RIoKYbVsAu1o5UGMeoSr0aHY9abq
         GHNJCjrPLT80YXMd2I7WPggRQdxLclHEM/fumqKV6Q9LNI9QS2vWxI9eEa+OCaa84jWP
         j5vXB3CubolpkJbruplmQIBLpJRLnRjlUY6ckjm8FxTUh1eEYv8Y+V1x2PSzGGnst6xZ
         OwS5DvjFRHvYVhNAI9hUBppvMmP6aMbwe2KS5czusr383bFEmBJOFtm21xLd1RE8fw7t
         no6Q==
X-Received: by 10.66.193.202 with SMTP id hq10mr65773789pac.57.1395580304862;
        Sun, 23 Mar 2014 06:11:44 -0700 (PDT)
Received: from [192.168.23.7] (nkn-admin-map.isical.ac.in. [14.139.222.67])
        by mx.google.com with ESMTPSA id vg1sm23241155pbc.44.2014.03.23.06.11.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Mar 2014 06:11:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAPig+cRL3zFWtBq_yJQqwGa7Wc6GsdBqA_jrGm8p5ZMJVmr-yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244793>


Thanks for your comments, Tanay and Eric.

Regarding the [PATCH v2], I will keep this in mind for the subsequent 
patches.

On 03/23/2014 02:10 PM, Eric Sunshine wrote:
> Thanks for the resubmission. Comments below...
>
> On Sat, Mar 22, 2014 at 11:12 AM, Ashwin Jha <ajha.dev@gmail.com> wrote:
>> Subject: [PATCH] Modify fsck_commit. Replace memcmp by skip_prefix
> In his review, Tanay already mentioned indicating a resubmission via
> [PATCH vN]. Additionally, specify the module or function being
> modified, followed by a colon and space. On this project, it is
> customary to forego capitalization in the subject (and only the
> subject). So, you might write:
>
>      Subject: [PATCH v2] fsck_commit: replace memcmp() by skip_prefix()
>
>> Replace memcmp by skip_prefix as it serves the dual
>> purpose of checking the string for a prefix as well
>> as skipping that prefix.
> Good.
>
>> Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
>> ---
> Tanay mentioned this already: Below the "---" line under your sign-off
> is where you should, as a courtesy to reviewers, explain what changed
> since the previous attempt. Also, provide a link to the previous
> version, like this [1].
>
> [1]: http://git.661346.n2.nabble.com/PATCH-GSoC-Miniproject-15-Rewrite-fsck-c-fsck-commit-td7606180.html
>
>>   fsck.c |   25 ++++++++++++++-----------
>>   1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/fsck.c b/fsck.c
>> index 64bf279..021b3fc 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -6,6 +6,7 @@
>>   #include "commit.h"
>>   #include "tag.h"
>>   #include "fsck.h"
>> +#include "git-compat-util.h"
>>
>>   static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
>>   {
>> @@ -284,21 +285,23 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
>>
>>   static int fsck_commit(struct commit *commit, fsck_error error_func)
>>   {
>> -       char *buffer = commit->buffer;
>> +       char *next_parent, *buffer = commit->buffer;
> The name 'next_parent' doesn't seem correct. After invoking
> skip_prefix(), this variable will point at the hex representation of
> the parent's SHA1, so a better name might be 'parent_id'.
>
>>          unsigned char tree_sha1[20], sha1[20];
>>          struct commit_graft *graft;
>>          int parents = 0;
>>          int err;
>>
>> -       if (memcmp(buffer, "tree ", 5))
>> +       buffer = (char *)skip_prefix(buffer, "tree ");
> These casts are ugly. It should be possible to get rid of all of them.
> Hint: Does this function modify the memory referenced by 'buffer'?
> (The answer is very slightly involved, though not difficult. A proper
> fix would involve turning this submission into a 2-patch series: one a
> preparatory patch, and the other this patch without the casts.)
Eric, certainly this function does not modify the memory referenced by 
'buffer'.
So, 'buffer' should be declared as a const char *.
But, what about the argument to fsck_ident(). First argument required is 
a char **.
Now, the compiler will correctly give a warning for incorrect argument type.

I have seen the code of fsck_ident(), and it is nowhere modifying the 
memory referenced by
buffer. So, I know that this will not cause any problem. But, still it 
will be a bad practice to do away with
warnings.

And can you explain me a bit about a 2-patch series.

Once again thanks for your help.
>> +       if (buffer == NULL)
>>
>> On this project, it is customary to say !buffer. Ditto for the
>> remaining instances.
>>
>>                  return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>> -       if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
>> +       if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
>>                  return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
>> -       buffer += 46;
>> -       while (!memcmp(buffer, "parent ", 7)) {
>> -               if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
>> +       buffer += 41;
>> +       while ((next_parent = (char *)skip_prefix(buffer, "parent ")) != NULL) {
> Likewise, on this project, it is customary to omit the '!= NULL'.
>
>> +               buffer = next_parent;
>> +               if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
>>                          return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
>> -               buffer += 48;
>> +               buffer += 41;
>>                  parents++;
>>          }
>>          graft = lookup_commit_graft(commit->object.sha1);
>> @@ -322,15 +325,15 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>>                  if (p || parents)
>>                          return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
>>          }
>> -       if (memcmp(buffer, "author ", 7))
>> +       buffer = (char *)skip_prefix(buffer, "author ");
>> +       if (buffer == NULL)
>>                  return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
>> -       buffer += 7;
>>          err = fsck_ident(&buffer, &commit->object, error_func);
>>          if (err)
>>                  return err;
>> -       if (memcmp(buffer, "committer ", strlen("committer ")))
>> +       buffer = (char *)skip_prefix(buffer, "committer ");
>> +       if (buffer == NULL)
>>                  return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
>> -       buffer += strlen("committer ");
>>          err = fsck_ident(&buffer, &commit->object, error_func);
>>          if (err)
>>                  return err;
> Other than the minor points mentioned above, the patch looks good. Thanks.
>
>> --
>> 1.7.9.5
Regards,
Ashwin
