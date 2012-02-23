From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv3 3/5] tag --exclude option
Date: Wed, 22 Feb 2012 16:22:15 -0800
Message-ID: <20120223002215.GE2410@tgrennan-laptop>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
 <1329874130-16818-4-git-send-email-tmgrennan@gmail.com>
 <7vhayjbcna.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 01:22:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0MS1-00071M-NS
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 01:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab2BWAWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 19:22:21 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:45992 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab2BWAWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 19:22:20 -0500
Received: by qafk1 with SMTP id k1so836586qaf.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 16:22:20 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.229.136.196 as permitted sender) client-ip=10.229.136.196;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.229.136.196 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.229.136.196])
        by 10.229.136.196 with SMTP id s4mr24509735qct.71.1329956540021 (num_hops = 1);
        Wed, 22 Feb 2012 16:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tNhZkhHZ1Ge7zkFg27G8iT9vJEr/BegnbftFhDLrxN0=;
        b=gecUvSXyjwBVrqW+8BUhgDssyjOv5eKp1khFoTavy+f4Li6MlKV/fSAoLRTIJbEcrZ
         NEOlUj+SQm+wlUk6bSD6hxt/TdmgYsSic5tNVUurGypiURiU/Hwo6hKd9Z3SijZ33E3J
         3dJ6GQwfvYdFzWw5MhDlbUAXcHA1wjZOsilmo=
Received: by 10.229.136.196 with SMTP id s4mr20754003qct.71.1329956539657;
        Wed, 22 Feb 2012 16:22:19 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id f12sm59473825qan.1.2012.02.22.16.22.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 16:22:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhayjbcna.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191314>

On Tue, Feb 21, 2012 at 10:33:29PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> Example,
>>   $ git tag -l --exclude "*-rc?" "v1.7.8*"
>>   v1.7.8
>>   v1.7.8.1
>>   v1.7.8.2
>>   v1.7.8.3
>>   v1.7.8.4
>>
>> Which is equivalent to,
>>   $ git tag -l "v1.7.8*" | grep -v \\-rc.
>>   v1.7.8
>>   v1.7.8.1
>>   v1.7.8.2
>>   v1.7.8.3
>>   v1.7.8.4
>>
>> Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
>
>Having an example is a good way to illustrate your explanation, but it is
>not a substitution.  Could we have at least one real sentence to describe
>what the added option *does*?
>
>This comment applies to all the patches in this series except for the
>second patch.
>

OK, I'll add the "exclude" option description from the respective man pages.

>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index 8d32b9a..470bd80 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -13,7 +13,7 @@ SYNOPSIS
>>  	<tagname> [<commit> | <object>]
>>  'git tag' -d <tagname>...
>>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>> -	[<pattern>...]
>> +	[--exclude <pattern>] [<pattern>...]
>>  'git tag' -v <tagname>...
>>  
>>  DESCRIPTION
>> @@ -90,6 +90,10 @@ OPTIONS
>>  --points-at <object>::
>>  	Only list tags of the given object.
>>  
>> +--exclude <pattern>::
>> +	Don't list tags matching the given pattern.  This has precedence
>> +	over any other match pattern arguments.
>
>As you do not specify what kind of pattern matching is done to this
>exclude pattern, it is important to use the same logic between positive
>and negative ones to give users a consistent UI.  Unfortunately we use
>fnmatch without FNM_PATHNAME for positive ones, so this exclude pattern
>needs to follow the same semantics to reduce confusion.
>
>This comment applies to all the patches in this series to add this option
>to existing commands that take the positive pattern.

OK, should I also describe the --no-exclude option?

>> @@ -202,6 +206,15 @@ test_expect_success \
>>  '
>>  
>>  cat >expect <<EOF
>> +v0.2.1
>> +EOF
>> +test_expect_success \
>> +	'listing tags with a suffix as pattern and prefix exclusion' '
>> +	git tag -l --exclude "v1.*" "*.1" > actual &&
>> +	test_cmp expect actual
>> +'
>
>I know you are imitating the style of surrounding tests that is an older
>parts of this script, but it is an eyesore.  More modern tests are written
>like this:
>
>	test_expect_success 'label for the test' '
>		cat >expect <<-EOF &&
>                v0.2.1
>		EOF
>	        git tag -l ... >actual &&
>		test_cmp expect actual
>	'
>
>to avoid unnecessary backslash on the first line, and have the preparation
>of test vectore _inside_ test_expect_success.  We would eventually want to
>update the older part to the newer style for consistency.
>
>Two possible ways to go about this are (1) have a "pure style" patch at
>the beginning to update older tests to a new style and then add new code
>and new test as a follow-up patch written in modern, or (2) add new code
>and new test in modern, and make a mental note to update the older ones
>after the dust settles.  Adding new tests written in older style to a file
>that already has mixed styles is the worst thing you can do.
>
>This comment applies to all the patches in this series with tests.

I'd prefer, (1) precede each "--exclude" patch with a "pure style" patch
to update the respective tests.  However, since this will result in a
lot of conflict with concurrent development;  I'll separate the test
patches from the code and documentation.  I'll then cycle on rebasing
the style and new test patches until the development of each is
quiescent.

Thanks,
TomG
