Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327391F453
	for <e@80x24.org>; Tue,  2 Oct 2018 21:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJCDpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 23:45:30 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:13929 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeJCDpa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 23:45:30 -0400
Received: from [192.168.1.4] ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id 7Rm9gd7fppXFj7Rm9guGv1; Tue, 02 Oct 2018 22:00:13 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=anyJmfQTAAAA:8
 a=uPZiAMpXAAAA:8 a=iiQuyQKBzodtzL9u7X8A:9 a=QEXdDO2ut3YA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22
Subject: Re: git projects with submodules in different sites - in txt format
 (:+(
To:     Michele Hallak <mhallak@iai.co.il>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <15774B2750A13244948B89FDD2FEC2EACF15C69A@EXS11.iai.co.il>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <b059c580-28d2-9f97-7ded-9bdd60b45a54@iee.org>
Date:   Tue, 2 Oct 2018 22:00:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <15774B2750A13244948B89FDD2FEC2EACF15C69A@EXS11.iai.co.il>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHlL6EXSkMHtEiggcui9pZDMQB3dDM3OrCGSbf+Mr9DK2Up3PGSyjpUyp0JlSRWxqf9iZtz7Lg+2RXUWfzTZWCw50Hm/4l5lDXyKG7lAtVKj40eztYSw
 fA+rDJXTah5zfgIr5h5EJUhtEFFIQucVOhNLjbkwVBr/IbfRnwxOBNLxI4QEqMHjcWfOHrGMJYp3UUz9kHVEvwuWX0xQVfmpCkk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2018 06:47, Michele Hallak wrote:
> Hi,
> 
> I am getting out of idea about how to change the methodology we are using in order to ease our integration process... Close to despair, I am throwing the question to you...
> 
> We have 6 infrastructure repositories [A, B, C, D, E, F ?].

> Each project [W,X,Y,Z] is composed of 4 repositories [1-4], each one using one or two infrastructure repositories as sub-modules. (Not the same)

e.g. W1-W4; with say B & D as submodules
> 
> The infrastructure repositories are common to several projects and in the case we have to make change in the infrastructure for a specific project, we are doing it on a specific branch until properly merged.

Do you also have remotes setup that provide backup and central authority 
to the projects..?
> 
> Everything is fine (more or less) and somehow working.

Good..
> 
> Now, we have one project that will be developed in another site and with another git server physically separated from the main site.

Is it networked? Internal control, external internet, sneakernet?
> 
> I copied the infrastructure repositories in the new site and removed and add the sub-modules in order for them to point to the url in the separated git server.
> 
> Every 2 weeks, the remotely developed code has to be integrated back in the main site.
> My idea was to format GIT patches, integrate in the main site, tag the whole thing and ship back the integrated tagged code to the remote site.
> ... and now the nightmare starts:
yep, you have lost the validation & verification capability of Git's 
sha1/oid and DAG.

> 
> Since the .gitmodules is different, I cannot have the same SHA and then same tag and I am never sure that the integrated code is proper.

Remotes, remotes...
> 
> May be there is a simple solution that I don't know about to my problem? Is there something else than GIT patches? Should I simply ship to the remote site the code as is and change the submodules each time?
>

I think the solution you need is `git bundle` 
https://git-scm.com/docs/git-bundle. This is designed for the case where 
you do not have the regular git transport infrastructure. Instead it 
records the expected data that would be 'on the wire', which is then 
read in at the far end. The bundle can contain excess data to ensure 
overlap between site transmissions.

You just run the projects in the same way but add the courier step for 
shipping the CD, or some password protected archive as per your security 
needs.

Everything is should be just fine (more or less) and somehow it will 
just work. ;-)

--
Philip
https://stackoverflow.com/questions/11792671/how-to-git-bundle-a-complete-repo
