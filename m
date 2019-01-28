Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DFE51F453
	for <e@80x24.org>; Mon, 28 Jan 2019 20:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfA1UNK (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 15:13:10 -0500
Received: from avasout05.plus.net ([84.93.230.250]:44642 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1UNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 15:13:09 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id oDHGgAYPXuQOBoDHHg7hXO; Mon, 28 Jan 2019 20:13:08 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=JtDfUvwC c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VwQbUJbxAAAA:8 a=1tH51EEBQ01Cu-h4RToA:9
 a=QEXdDO2ut3YA:10 a=pXTjMIipiugA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: sparse job, was Re: [PATCH] test-xml-encode: fix sparse NULL
 pointer warnings
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <68a8c70e-dc42-1df3-3616-c096f63cb848@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1901281706440.41@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a6b689da-b002-0aa2-e9d6-755d004bc320@ramsayjones.plus.com>
Date:   Mon, 28 Jan 2019 20:13:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1901281706440.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGuJRpBOCxWykThZtCCf8IrcVXFnBYbrsf3OcDrzZmLqYzK3LXwGrXvNYO74cKfUd0booQxKZn2312UlZdCCCkM7zB31EexJzTSQ8eAtvvXc9vS+Ol93
 twgZlGQAss5i65X8XCIMo5MMR5KmMOEC0sKcXpcu/KspbVMkx1rDIZwja5/LZHUoVbvm2X8oUoqHrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/01/2019 16:10, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Sat, 26 Jan 2019, Ramsay Jones wrote:
> 
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Johannes,
>>
>> If you need to re-roll your 'js/vsts-ci' branch, could you please
>> squash this into the relevant patch (commit af7747e7c7 ("tests: optionally
>> write results as JUnit-style .xml", 2019-01-23)).
> 
> Certainly!
> 
> BTW would you be interested in working with me on an Azure Pipeline that
> runs `sparse` on all of Junio's branches? (I am now pretty proficient with
> building a software package in one Azure Pipeline, publishing it as a
> build artifact, then consuming it from another Azure Pipeline, so I would
> build the `sparse` package as an Ubuntu package and offer it as a build
> artifact.)

Happy to help, if I can.

Looking at the sparse wiki [1] we can see that the most recent
release of sparse is v0.6.0, released on December 26th 2018
(just too late for crimble!).  This is the release you will
need to use for more recent Linux distros (eg. fedora 27+,
Ubuntu 18.04, 18.10, etc).

The releases are available from [2] as a compressed tar-ball
using '.gz' or .'xz' compression. eg. sparse-0.6.0.tar.gz
(there is also a sparse-0.6.0.tar.sign).

[The git repo is at [3], BTW].

[I was a little surprised that Linux Mint 19.1 (based on Ubuntu
18.04) has v0.5.1 - Debian unstable has v0.5.2, but both of those
are just a little too old for use with git on recent Linux.]

It seems Ubuntu has split sparse into two packages, the main
'sparse' package, which contains the command-line programs and
a 'sparse-test-inspect' package, which contains the 'test-inspect'
GUI program (and so depends on GTK).

The dependencies for the 'sparse' package includes: libc6 (>= 2.14),
libllvm4.0 (>= 1:4.0~), libxml2 (>= 2.7.4), perl:any

However, for git, we only need to build 'cgcc' and 'sparse', which
means we can forget about libxml (only used for c2xml), and libllvm
(only used for sparse-llvm/sparsec/sparsei). Also, I'm not sure what
perl is doing there ...

Note that these dependencies (along with the dependent programs) are
optional and I can happily build sparse without them:

  $ make clean
  Makefile:124: Your system does not have libxml, disabling c2xml
  Makefile:146: Your system does not have gtk3/gtk2, disabling test-inspect
  Makefile:179: Your system does not have llvm, disabling sparse-llvm
    CLEAN
  $ 

Hmm, I've never built an Ubuntu package before, so I don't know
exactly what would be required (spec file etc.) to create a PPA.
But I suspect you are not talking about doing that, right?

ATB,
Ramsay Jones

[1] https://sparse.wiki.kernel.org/index.php/Main_Page
[2] http://www.kernel.org/pub/software/devel/sparse/dist/
[3] git://git.kernel.org/pub/scm/devel/sparse/sparse.git

