Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5974A1F461
	for <e@80x24.org>; Sun, 12 May 2019 20:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfELUYw (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 16:24:52 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:23290 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELUYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 16:24:52 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id Pv1bhpF6UdraxPv1bhyGsa; Sun, 12 May 2019 21:24:48 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=FpKl-_2GAAAA:8 a=jMxcBBy747LfIDSGNE0A:9
 a=QEXdDO2ut3YA:10 a=bjMnQbrZbU-JQMd83uSx:22
Subject: Re: [PATCH v2 1/1] diff-highlight: Use correct /dev/null for UNIX and
 Windows
To:     Chris Webster <chris@webstech.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.59.git.gitgitgadget@gmail.com>
 <pull.59.v2.git.gitgitgadget@gmail.com>
 <bcbffa141116f869db40e4572f9824a3d090c20c.1541026721.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1811061501210.86@tvgsbejvaqbjf.bet>
 <CAGT1KpVn536+B6-8=opNAVnz3_w13Kx3LyED0Gbk+4DtwmoP6Q@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <d8bd7df9-ec1a-3012-488e-1986dee9c9a5@iee.org>
Date:   Sun, 12 May 2019 21:24:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGT1KpVn536+B6-8=opNAVnz3_w13Kx3LyED0Gbk+4DtwmoP6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfKOM9hqiqI1YhiXSQ4I/RXc0IF6ASogGU4789eAfxo3kgbIDL72Ey9dxfO4tWunsw3FPENL6eNBJEdpDO+mSIaXPrHVxQtsLeNbq76fw/CRa8aHu9vxz
 RUN93dI8O8IdM5sGVD47yQyXD15htRnTUP30xKwuc+Fh1BI/D7Or/2cHRGUemxpcrJMRoaeNNtyPyGIkiiuvmX9N1ajPXE5HpcIG1vDZ2yvpBwJMWcNCkNV/
 5D9Kn7yzUR2PjzqZQX01b9y9YpUY8RRNAyyxXu4oQzyN5/SuVvv3BPXdvhoe+sTN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,


On 07/05/2019 05:18, Chris Webster wrote:
> I know these can take some time but is this pending any update from
> me?  The accepted changes will be merged back into the diff-so-fancy
> project.
>
> There was a question about other uses of /dev/null.  In the contrib
> directory, there are a couple of uses.
>
> contrib/buildsystems/engine.pl - not clear if this is still of use or
> always expects to always be running in a mingw type environment.
While the `contrib/buildsystems/engine.pl ` is not often used, it does 
provide a route for users of older Visual studio version.
I'm not sure if the mingw environment is relevant to its operation - I'd 
expect it (the generation of an .sln that would compile) to still work 
with the current MSYS2 basis, but the `install` process was never fully 
completed (an probably isn't a worthwhile project unless you have the 
particular itch to scratch).

The newer MSVC=1 build process using vcpkg has solved most of the 
issues, but I'm getting a couple of issues with some of the 
libraries/include paths with the latest VS2017, see issue #2186 / #2179 
/ https://groups.google.com/forum/#!topic/git-for-windows/Y99a0dzlVJY , 
though hopefully I'll get them sorted this week.

> contrib/mw-to-git/git-remote-mediawiki.perl - this is cloned from a
> separately maintained github project.  Should any changes be issues on
> that project?
>
> thanks,
> ...chris.
>
> On Tue, Nov 6, 2018 at 6:02 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> List,
>>
>> I have no idea why this mail made it to GitGitGadget's email account but
>> not to the Git mailing list... Sorry about that.
>>
>> Ciao,
>> Johannes
>>
>> On Wed, 31 Oct 2018, Chris. Webster via GitGitGadget wrote:
>>
>>> From: "Chris. Webster" <chris@webstech.net>
>>>
>>> Use File::Spec->devnull() for output redirection to avoid messages
>>> when Windows version of Perl is first in path.  The message 'The
>>> system cannot find the path specified.' is displayed each time git is
>>> run to get colors.
>>>
>>> Signed-off-by: Chris. Webster <chris@webstech.net>
>>> ---
>>>   contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
>>> index 536754583b..7440aa1c46 100644
>>> --- a/contrib/diff-highlight/DiffHighlight.pm
>>> +++ b/contrib/diff-highlight/DiffHighlight.pm
>>> @@ -4,6 +4,11 @@ use 5.008;
>>>   use warnings FATAL => 'all';
>>>   use strict;
>>>
>>> +# Use the correct value for both UNIX and Windows (/dev/null vs nul)
>>> +use File::Spec;
>>> +
>>> +my $NULL = File::Spec->devnull();
>>> +
>>>   # Highlight by reversing foreground and background. You could do
>>>   # other things like bold or underline if you prefer.
>>>   my @OLD_HIGHLIGHT = (
>>> @@ -134,7 +139,7 @@ sub highlight_stdin {
>>>   # fallback, which means we will work even if git can't be run.
>>>   sub color_config {
>>>        my ($key, $default) = @_;
>>> -     my $s = `git config --get-color $key 2>/dev/null`;
>>> +     my $s = `git config --get-color $key 2>$NULL`;
>>>        return length($s) ? $s : $default;
>>>   }
>>>
>>> --
>>> gitgitgadget
>>>

