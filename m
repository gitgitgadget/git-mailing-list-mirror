Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CACB1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 16:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbcF3Qwf (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 12:52:35 -0400
Received: from mout.web.de ([212.227.15.3]:58962 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbcF3Qwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 12:52:34 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MGifp-1b5F510oML-00DUlS; Thu, 30 Jun 2016 18:52:26
 +0200
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
To:	Junio C Hamano <gitster@pobox.com>, tboegi@web.de
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
 <1467100876-2803-1-git-send-email-tboegi@web.de>
 <xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <62eb3d75-126e-427b-8701-d490e80e3501@web.de>
Date:	Thu, 30 Jun 2016 18:52:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ECM9iIlyYKMU75BnFxZRx53CjwNw2bU/pYhCXhDYkilwPFstlOb
 0qiz39CtDEfYLhfJIp/L0xKge/4IiCiApEwOdqtN1YFvYafXnQPrV29PFEb8NyG2XQ4fszp
 TBsx+xx9SExYUMKe/WUhmTfCIay8HfPw0hLwK6I5HzBixqwH0Kd8FcjUsPGrGOCr8BqGJLb
 +rRt1qduuD3Om5ab28Utg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:J7/5wux/pfU=:qSX17ARzUyK5uGO2u9hvRy
 rOF32IfDE9T4Q5U7jvPzUD+fc9UXt0WbZU9XsvVoFXvkB91nMegy5hzwTLHd2OlT3NlPHHTzG
 EZA61ry+MhL2zCp4Df0XLhNipMxAtUSo4K3WzbM2jbCYXllN/8ZQpd2uGXLpedzEM6fSuJieT
 lxZjS0uNe6IG5FfkLRnNdlE7bKDTNgsObt5X1gGPShERncJRXHkNr16cPIimLR4swUdF0MZCE
 2cP9+qCvbdwHALRs4h5UkpLxtDHk7Q9WDBAxLhCMAvDLLUK8opi+PFaqEa9E/7ef9p2qmWm55
 NmplatqmW4s/g3obMwXV73iGexgBUSnk3w5F6Poq8ZLLLRkgMnY8ZnfFZP8DZPLB0O5PA+Jve
 vvMxC7fq6wsHkytpAC0rakQIc5yrYcwATN6EcZRrdRpaucoOVrQemH/droBRVhst9yTnxG83E
 +3k/bjzPiquAUPY+mSVrZKE05qLr7KZE/3gXxFF+GqR3BN7hPAjrC0ELRkREK3eJ51sanCzGl
 L6iAk0NpVOrBTJKhqZAKbTJt4lgoMwf+OgegHo1uzq8XgezedEAE9C4SdhfRiaGBnN7B9gstI
 Ow3iDJQ0cKAcPPtIQtTH/ldk2TSVZxoPx+lmkhHuO8DF4l1dNAgOFpmHZWMhfpu1HntEC65gq
 9mJ5nbOdG8uI22HmjNi2zf7XGXv9LuUbZtwrLT9NJhkYZ7TODSZFJJtS8TBJxS6BSezRGquVK
 4FUYyHx7CGHGIhtqylq1iRMtbEGw6ic1wmZ83caPMgEf7ynNzEgeHtrojlwoHztYOURs7OTWV
 kheeMXP
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 29.06.16 18:14, Junio C Hamano wrote:
> tboegi@web.de writes:
> 
>> From: Torsten Bögershausen <tboegi@web.de>
>>
>> The following didn't work as expected:
> 
> Sorry for being slow (not in response but in understanding), but
> let's examine the expectation first.

Thanks for the patience.
There is one detail missing in my description:
The check if a file in the working tree is clean:

static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
{
	int match = -1;
	int fd = open(ce->name, O_RDONLY);

	if (fd >= 0) {
		unsigned char sha1[20];
		unsigned flags = HASH_USE_SHA_NOT_PATH;
------------------
Remove the "new feature":

git diff  read-cache.c
diff --git a/read-cache.c b/read-cache.c
index dd98b36..1f951ea 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -170,7 +170,7 @@ static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 
        if (fd >= 0) {
                unsigned char sha1[20];
-               unsigned flags = HASH_USE_SHA_NOT_PATH;
+               unsigned flags = 0;//HASH_USE_SHA_NOT_PATH;
                memcpy(sha1, ce->sha1, sizeof(sha1));
                if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, flags))
                        match = hashcmp(sha1, ce->sha1);

The the problem can be re-produced, and debugged with help of t6038:

not ok 5 - Merge addition of text=auto eol=CRLF


> 
>>  - In a middle of a merge
>>  - merge.renormalize is true,
> 
> gitattributes(5) tells us that this would make a "virtual check-out
> and check-in of all stages", i.e. each of the three blob objects
> involved is run through convert_to_working_tree(), and the result is
> run through convert_to_git().  Now, what are these two operations
> told to do?
> 
>>  - .gitattributes = "* text=auto"
>>  - core.eol = crlf
> 
> git-config(1) tells us that a text file will be checked out with
> CRLF line endings, so convert_to_working_tree() would work that
> way.  Even though core.eol entry in that manual page does not tell
> us anything, presumably convert_to_git() is expected to turn it back
> to LF line endings.
> 
Yes, the git-config(1) may need improvements, but that can go as a later path.

>> Merge a blob with CRLF "first line\r\nsame line\r\n" and a blob
>> with LF "first line\nsame line\n".
I may have written:
Merge a blob with CRLF "first line\r\nsame line\r\n" 
(which is checked out as
"first line\r\nsame line\r\n" 
in the working tree, and therefore clean)
and a blob with LF "first line\nsame line\n".

> 
> The former, when renormalized, should (we are discussing the
> expectation, not necessarily what is done by today's code) be
> processed like this:
> 
>  * Pretend as if blob "first line\r\nsame line\r\n" is in the stage
>    #0 of the index at the path;
>  * Pretend as if the user said "git checkout" that path;
>  * Pretend as if the user then said "git add" that path.
> 
> The checkout process hopefully does not blindly turn LF into CRLF,
> making it "first line \r\r\nsame line\r\rn".  Instead the (virtual)
> working tree file will have "first line\r\nsame line\r\n".
Yes
> 
> Then "git add" should turn that CRLF into LF, which would give us
> "first line\nsame line\n", but because the "safer autocrlf" rule
> prevents it from happening.  The (real) index already has CR in it
> in the blob in stage #2, so the check-in process would (this is not
> describing the ideal, but what is done by today's code) disable
> CRLF->LF conversion.
> 
> Is that the problem you are trying to solve?
Not sure, if that problem isn't already solved.

> 
> If that is the case, I do not see how "don't use stage #2 of the
> real index; use the blob being renormalized instead" would help.
> The blob being renormalized may have CR in it, triggering that
> "safer autocrlf" rule and cause you the same trouble, no?
> 
> To me, it appears that if you consider that the "safer autocrlf" is
> a sensible thing, you _must_ expect that the renormalization would
> not work at all, in the scenario you presented.  Also,
> 
>> The expected result of the merge is "first line\nsame line\n".
> 
> if you expect this, to me, it appears that you need to reject the
> "safer autocrlf", at least during renormalization, as a sensible
> thing.  And if you _are_ to disable the "safer autocrlf" thing, then
> it does not matter what is currently in the index--the conversion
> can happen solely based on the data being converted and the
> configuration and attribute settings.
> 
> So I still do not see why you want to pass "no do not use stage #0
> or stage #2; use this blob instead".  Shouldn't you be just passing
> a bit "don't do the safer autocrlf thing in this convert_to_git()
> call" from renormalization codepath without doing anything else?
> 

This is my understanding:
- git checkout and git add are working as expected:
  LF in blob gives CRLF in the working tree at checkout (if attr says "auto")
  CRLF in blob gives CRLF in the working tree at checkout.
  CRLF in the working tree gives CRLF in the blob at "git add", when
  the new safer CRLF handling says so.

- Merges
 First the working tree is checked, if it is clean.
 I haven't digged deep enough to follow the whole code path,
 but that is what ce_compare_data() does, and it fails in a merge.

 Next thing is that the blobs are merged, and when a blob with CRLF
 is merged with a blob with LF, there are only conflicts :-(
 (Remember that both may have CRLF in the worktree)
 And here renormalize_buffer() comes in (only when "merge.renormalize" is true):
 - convert the blob with convert_to_working_tree_internal() into the working
    tree format (but do it in memory), and back to the "blob":
 - convert_to_git(path, src, len, dst, SAFE_CRLF_RENORMALIZE, NULL);

 Note the the "new safer autocrlf" is suppressed here, because of SAFE_CRLF_RENORMALIZE.
 The result is, that both blobs are now normalized, having LF.
 After that, they are merged.

This is my understanding: there are 2 different things involved in t6038#5:
- check for a clean worktree in ce_compare_data() # fails -> this is the problem to be solved
- When merge.renormalize is true: renormalize the buffers before the blobs are merged # -> works




