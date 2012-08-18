From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH v3 2/2] git-svn.perl: keep processing all commits in parents_exclude
Date: Sat, 18 Aug 2012 16:43:45 -0400
Message-ID: <CAK8d-aKMsSQGMmLrUFDCr1VDbxGPVsPJFgR=Okd-=7BV3AjzOQ@mail.gmail.com>
References: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
 <1344705265-10939-2-git-send-email-stevenrwalter@gmail.com> <502FF250.6010402@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: normalperson@yhbt.net, avarab@gmail.com, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Aug 18 22:44:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2psU-0004ug-8G
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 22:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab2HRUoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 16:44:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61965 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab2HRUoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 16:44:06 -0400
Received: by dady13 with SMTP id y13so1390966dad.19
        for <git@vger.kernel.org>; Sat, 18 Aug 2012 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+evA/9o/04PxpcHe444wdJz1jy06EdvWf47OOVxsdl4=;
        b=aZznhVeor+vSpANW5q1K86oAsuwRPbKEwyw4PqypKKijK21caXU+TgsYGi+OBcJ3L/
         WnTnVXjeWG5i0YMIrlpotc8jjqkNsQadMXt1ktvfp7vPikvXtZF+qzMMshJk3zT/ZcKC
         fUfrRXAKapM5Z73CjMfLscOV1vjCy2swhd7nfaFdyP4MMXS82ILbkd9mwx8MU/+obPkz
         LRN0G9/x4ziiAS26X5T0qGUU9C0NTosz80W4t2FE5wWfqMPKNn+anT1ewJd3tfNPp6EN
         RgVpnY076tpxT6+8N52cOOPJNMRY6FC7zlo56ao6r8fIjAkKuSida0/QgDhFvNUp6jhf
         xxjg==
Received: by 10.68.224.70 with SMTP id ra6mr22159922pbc.11.1345322646209; Sat,
 18 Aug 2012 13:44:06 -0700 (PDT)
Received: by 10.142.207.17 with HTTP; Sat, 18 Aug 2012 13:43:45 -0700 (PDT)
In-Reply-To: <502FF250.6010402@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203699>

On Sat, Aug 18, 2012 at 3:51 PM, Sam Vilain <sam@vilain.net> wrote:
> On 08/11/2012 10:14 AM, Steven Walter wrote:
>>
>> This fixes a bug where git finds the incorrect merge parent.  Consider a
>> repository with trunk, branch1 of trunk, and branch2 of branch1.
>> Without this change, git interprets a merge of branch2 into trunk as a
>> merge of branch1 into trunk.
>>
>> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
>> ---
>>   git-svn.perl                                     |    1 -
>>   t/t9164-git-svn-fetch-merge-branch-of-branch2.sh |   53
>> ++++++++++++++++++++++
>>   2 files changed, 53 insertions(+), 1 deletion(-)
>>   create mode 100755 t/t9164-git-svn-fetch-merge-branch-of-branch2.sh
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index abcec11..c4678c1 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -3623,7 +3623,6 @@ sub parents_exclude {
>>                                 if ( $commit eq $excluded ) {
>>                                         push @excluded, $commit;
>>                                         $found++;
>> -                                       last;
>>                                 }
>
>
> I could believe that, too.  I like this change: one line of code, 53 lines
> of test and a paragraph of explanation :-).

How about a Signed-Off-By?
-- 
-Steven Walter <stevenrwalter@gmail.com>
