Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D12AC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120F360E8F
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 14:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhJ1OUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:20:07 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:61813 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhJ1OUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 10:20:06 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mg6Dq-0003an-AF; Thu, 28 Oct 2021 15:17:38 +0100
Message-ID: <dac200db-fc5d-41da-668e-853a2f4f02a2@iee.email>
Date:   Thu, 28 Oct 2021 15:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [Summit topic] The state of getting a reftable backend working in
 git.git
Content-Language: en-GB
To:     Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211148400.56@tvgsbejvaqbjf.bet>
 <CAFQ2z_NBOC5sDSL6AjCe-5mPVhU1B_guJEsHwVT3=AK1aAt8UA@mail.gmail.com>
 <211026.86wnm021ih.gmgdl@evledraar.gmail.com>
 <CAFQ2z_OfWe53zh-Eu09M=7pxD4=AMiWrNvwqv_HB7NFNRX+dhw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAFQ2z_OfWe53zh-Eu09M=7pxD4=AMiWrNvwqv_HB7NFNRX+dhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/10/2021 09:12, Han-Wen Nienhuys wrote:
> On Tue, Oct 26, 2021 at 12:16 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> From memory I think the more general concern Philip Oakley was also
>> expressing (but maybe he'll chime in) could also be addressed by a tool
>> that just un-reftable-ifies a repository.
>>
>> I think such a thing would be useful, and I think we don't have that
>> already. Isn't the files backend or reftable usage now an "init"-time
>> setting.
>> ..
>> Maybe there's more complexity I'm not considering than just the *.lock
>> dance in .git/*, but if not such a tool could also convert freely
>> between the two backends, so you could try refable out in an existing
>> checkout.
> I added a convert-ref-storage command to the JGit command line client
> for exactly this,
>
> $ jgit convert-ref-storage  -h
> jgit convert-ref-storage [--format VAL] [--help (-h)] [--ssh [JSCH | APACHE]]
>
>  --format VAL          : Format to convert to (reftable or refdir) (default:
>                          reftable)
>  --help (-h)           : display this help text (default: true)
>  --ssh [JSCH | APACHE] : Selects the built-in ssh library to use, JSch or
>                          Apache MINA sshd. (default: JSCH)
>
> See here[1] for implementation. It's not safe for concurrent use with
> other git commands, but that's hardly a common use-case.
>
> [1] https://eclipse.googlesource.com/gerrit/jgit/jgit/+/1825a2230c06e7a6cbe23c69b63c3b7ecd2ceac6/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/file/FileRepository.java#806

Useful to know that there is a method, though I was distinguishing the
inspection of the data, from the conversion between (in-use) storage types.

My request was more about having an easy access ramp for on-boarding new
users (who are likely to visualise the file system analogy better) than
for experienced Git admins and developers who may need to convert and
interact with the data.

Some aspects (in the wider domain) may be the extending of the
documentation to help users with understanding the ref manipulation and
the meanings of the values.
-- 

Philip
>

