Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3152B1F42D
	for <e@80x24.org>; Fri, 25 May 2018 06:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeEYGDu (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 02:03:50 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61386 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751266AbeEYGDs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 May 2018 02:03:48 -0400
X-AuditID: 1207440f-00e0070000000adc-49-5b07a7436a04
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 58.21.02780.347A70B5; Fri, 25 May 2018 02:03:47 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC483.dip0.t-ipconnect.de [87.188.196.131])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w4P63i35012859
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 25 May 2018 02:03:45 -0400
Subject: Re: commit-graph: change in "best" merge-base when ambiguous
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>
References: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
 <3705af00-00b7-b620-cc77-eef8f0a73bc1@alum.mit.edu>
 <8b480e9e-1fd3-35ff-2974-653fadd49fa7@gmail.com> <86o9h41zc3.fsf@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <1fb58851-57bc-b787-fd38-474aa6afa8b3@alum.mit.edu>
Date:   Fri, 25 May 2018 08:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86o9h41zc3.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqOu8nD3aYO0HU4sX+y+zWnRd6Way
        aOi9wmyxe3E/s8WKq3OYLea1fGG2+NHSw2yxeXM7i8XRC2sYHTg9ds66y+6xYFOpx91n2xk9
        nvXuYfS4eEnZ4/MmuQC2KC6blNSczLLUIn27BK6M6xdeMhdc4654vmM5UwPjTs4uRk4OCQET
        iadHj7N3MXJxCAnsYJLY37WKBcK5wCSxbNZRVpAqYQFXiYlTvjGD2CICHhJN/yczgxQxC/Qz
        SUx68gyq4wCjxMNpD8A62AR0JRb1NDOB2LwC9hKf2xYygtgsAqoS3w4sAasRFYiQuHf+ExtE
        jaDEyZlPWEBsTgF1iRt/t4PVMAPZf+ZdYoawxSVuPZnPBGHLSzRvnc08gVFgFpL2WUhaZiFp
        mYWkZQEjyypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2MkHjh38HYtV7mEKMA
        B6MSD++GA2zRQqyJZcWVuYcYJTmYlER5Ty5ljxbiS8pPqcxILM6ILyrNSS0+xCjBwawkwjs5
        GCjHm5JYWZValA+TkuZgURLnZTXZGyUkkJ5YkpqdmlqQWgSTleHgUJLgjV0G1ChYlJqeWpGW
        mVOCkGbi4AQZzgM03Bikhre4IDG3ODMdIn+KUVFKnHcNyEUCIImM0jy4Xlg6e8UoDvSKMG8q
        SDsPMBXCdb8CGswENPjicmaQwSWJCCmpBkbtbfEn5+jfe9JkfL18cw7TXhfFql3xe+v/371Q
        qGRzcGbI7Q9SD3XlhL+lmP5aevP9Fua5pvc0uWN/7jq/8cCzh576bttCBTbNLzLisBLYPd/4
        xmHd2unr1iZPidD/Z+kz97xEu6TFVoatVhKnI0R1xFOWvWN7lXeqU57rQqeK3UaBguW/Mhcp
        sRRnJBpqMRcVJwIASlT+f0IDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/25/2018 12:08 AM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> On 5/22/2018 1:39 AM, Michael Haggerty wrote:
>>> On 05/21/2018 08:10 PM, Derrick Stolee wrote:
>>>> [...]
>>> This may be beyond the scope of what you are working on, but there are
>>> significant advantages to selecting a "best" merge base from among the
>>> candidates. Long ago [1] I proposed that the "best" merge base is the
>>> merge base candidate that minimizes the number of non-merge commits that
>>> are in
>>>
>>>      git rev-list $candidate..$branch
>>>
>>> that are already in master:
>>>
>>>      git rev-list $master
>>>
>>> (assuming merging branch into master), which is equivalent to choosing
>>> the merge base that minimizes
>>>
>>>      git rev-list --count $candidate..$branch
> 
> Is the above correct...
> 
>>> In fact, this criterion is symmetric if you exchange branch ↔ master,
>>> which is a nice property, and indeed generalizes pretty simply to
>>> computing the merge base of more than two commits.
> 
> ...as it doesn't seem to have the described symmetry.

The first email that I referenced [1] demonstrates this in the section
"Symmetry; generalization to more than two branches". The same thing is
demonstrated in a simpler way using set notation in a later email in
that thread [2].

Michael

[1] https://public-inbox.org/git/539A25BF.4060501@alum.mit.edu/
[2] https://public-inbox.org/git/53A06264.9080205@alum.mit.edu/
