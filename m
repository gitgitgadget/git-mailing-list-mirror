Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB5CC76195
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 02:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjC1CM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 22:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1CM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 22:12:57 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18D8F
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 19:12:55 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id qh28so8274457qvb.7
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 19:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p8oWXmiPTI0gdEmvPZQvQZHdN9QgADOrpnV6xUy5PE=;
        b=Q/1UEBZFVBsHS5ak42ejX6FhbY7l+cVKuuv1lpg10p6Y3n4mjYxfoRGwWV0A5akxA7
         9hxHy6ATgndWCOLpeSGTNyMb3XNNF89Kr0o0jrYHJHr48jVgizT71sY7G2e+lKLff7U1
         HfDNfs5u7DpAOOPrg/hUcXZIYGLfcik7Rttg2y8lI9c3kLHHO8DGy348zP6bP7RdrRR1
         YcbZW2+92nedL2W5lOg5JbJSMORSQ9KhYLL9VWdN3UXBsITN6fIODTi4S5KibvnxFrm6
         GvJohyGj1noU9gsvG6lVAkympTU1OwTg7IM0QSVoiKxIT9JjOJIgHx+ySo+XaHRQ2iAC
         h3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3p8oWXmiPTI0gdEmvPZQvQZHdN9QgADOrpnV6xUy5PE=;
        b=xgvZTdIQrHHMO7TEHzO8zgmDZCfWB5bs1nBrUVMfT3oquemAeOXJqEKxeBx9Jb6iQ8
         SBzrLGaB8016y96ekqO8NrGHljUuxYT81CqqjKYNvaMkXwhQp+Y3DsVtkK6xzGujUC0Q
         0gmQVk4YK590mf7yjampKg3Z87h84Pj+yJsY5rPdzH7HO6BYdLjMofhiW1S4nCH97Kqk
         RZ0NYQ/IwI2cv06vDkOCXVhBHnbu5xfO63kaXd9ClYqJu5WvvI03j+tnUjjVe2e2hHoi
         1iDkg6YKLZUkqJv+oV49guq9ZgxpnxLovW6bCbywReU7w6Q1ZisjI6RaE82lD36VBIbm
         EYlg==
X-Gm-Message-State: AAQBX9eZZXmjknRL0HkTTRyAVOR0TTSywFZktHbJKyqw6vgpanN+Vq5t
        gp/DaJsPhb05JqTHxDaz9yPKad8ObEA=
X-Google-Smtp-Source: AKy350bW/eUUa/bbFa+eZtEpi+jVioX8U0nkL2QjltJjMw1v+XcV21fVFzq677sU/voMTj1BrT8DOw==
X-Received: by 2002:a05:6214:2388:b0:579:5dbc:ab8b with SMTP id fw8-20020a056214238800b005795dbcab8bmr23786437qvb.52.1679969573537;
        Mon, 27 Mar 2023 19:12:53 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id m2-20020a0cee42000000b005dd8b93459dsm3416174qvs.53.2023.03.27.19.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:12:53 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [GSoC][RFC][PROPOSAL] More Sparse Index Integrations
Date:   Mon, 27 Mar 2023 22:12:43 -0400
Message-Id: <20230328021243.6641-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230328014927.5617-1-cheskaqiqi@gmail.com>
References: <20230328014927.5617-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello everyone,

Sorry about the wrapping mistake in last patch.

Here is the initial version of my proposal on "More Sparse Index 
Integrations". I would really love to have comments on it. If you find any 
mistakes please notify me about that.

And website version is there: 
https://docs.google.com/document/d/1WtoLgAJYVHY_NWNscqi358FeAY-6UBARCmpTU3BAQMs/edit#

==================================================================

## More Sparse Index Integrations
Personal Details

### About Me
| Name | Shuqi Liang |

| Mobile no. |  +1 (416) 272-1737|
| Email | cheskaqiqi@gmail.com|

| Github | https://github.com/Cheskaqiqi |
| Major | Computer Science |
| Time Zone | EDT （UTC  -4 hours） |
    

### Me & Git

I am a Computer Science undergraduate at Western University (Canada). I have 
learned C, Python, Java, and shell in the last two years. I have started 
exploring the Git codebase since Jan 2023.Here is some related documentation 
I have read:


# MyFirstContribution.txt   
# SubmittingPatches

*Way to make contributions to the git project.

# MyFirstObjectWalk.txt

*Way uses git's Object Walk API to traversethe git object database.
Topics such as object types and IDs.


# Hacking Git
# Understanding Git — Index 
# Git Internals
# UnderstandingGit  DataModel
# UnderstandingGit Branching
# Underlying data model of git and how it works.

*Types of git objects: blobs, trees, and commits.
*The concept of branching in Git and how it is used to manage code changes.
*Two layers of git: the low-level plumbing layer and the high-level 
porcelain layer.
*Relationship between the Index and the working directory.

# Make your monorepo feel small with 
# Bring your monorepo down to size with sparse-checkout 

*How the git sparse checkout and git sparse index feature can help make 
large monorepos feel smaller and more manageable

# Sparse-checkout.txt
# Sparse-index.txt

I would like to thank Shaoxuan, the 2022 GSoC who recommended these two 
articles to me. The articles cover some of the limitations and potential 
issues with ‘sparse-checkout’ and ‘sparse-index’.


###Contributions


#Status 
wip
#Subject
[Microproject]: t4113: modernize test script
#Mail List Link
https://lore.kernel.org/git/20230215023953.11880-2-cheskaqiqi@gmail.com/

#Status 
wip
#Subject
[Aided a potential GSoC student]: trace.c, git.c: removed unnecessary 
parameter to trace_repo_setup
#Mail List Link
https://lore.kernel.org/git/20230215175510.3631-1-cheskaqiqi@gmail.com/

#Status 
wip
#Subject
check-attr: integrate with sparse-index
#Mail List Link
https://lore.kernel.org/git/20230227050543.218294-2-cheskaqiqi@gmail.com/

#Status 
wip
#Subject
diff-files: integrate with sparse index
#Mail List Link
https://lore.kernel.org/git/20230322161820.3609-2-cheskaqiqi@gmail.com/




###The Project: More Sparse Index Integrations


#What's "sparse-checkout"

When the repository has so many files at root, it causes git commands to 
slow to a crawl (e.g., git checkout, git status). Now, ‘sparse-checkout’ 
allows users to restrict their working directory to only the files they care 
about. It is supposed to make users feel like they are in a small 
repository, even though they are contributing to a large one.[1]  
If users use the "microservices in a monorepo" pattern, "sparse-checkout" 
can ensure the developer workflow is as fast as possible while maintaining 
all the benefits of a monorepo.[1]



#What's ‘git index’

In git, the index, or the staging area, is an intermediate area where 
changes to a Git repository are prepared before committing to the 
repository. The index file stores a list of every file at HEAD. This list of 
files is stored as a flat list.[2]



#What's ‘sparse-index’

Although ‘sparse-checkout’  has done very well, it still has a problem: 
the Git index is still large in a monorepo.
‘sparse-index’ allows the index to focus on the files within the 
sparse-checkout cone. The size of the sparse index will scale with the number 
of files within users' chosen directories instead of the full size of the 
repository. When enabled with a number of other performance features, this 
can have a dramatic performance improvement.[2]



#Problem when integrated with sparse index

The idea of 'sparse index' is easy to understand, but pruning the index at 
the directory level may cause a complicated result. That is because, In the 
Git codebase, numerous places directly interact with the index in various 
nuanced ways. All of them assume that each index entry refers to a blob 
object. But sparse-directory entries violate expectations about the index 
format and its in-memory data structure. Many consumers in the codebase 
expect to iterate through all of the index entries and see only files. 
Compatibility layers are made to expand a sparse index to an equivalent full
 index. So that even if the on-disk format is sparse, code paths that have 
 not been integrated and tested with a sparse index can still be used.[2]

The Git Fundamentals team first started by creating the ensure_full_index() 
method, which converts a sparse index into a full one. 

But this method takes longer to expand a sparse index to a full one than to 
read a full one from a disk. It goes against our idea of utilizing 
'sparse index' to enhance user experience. To gain the performance benefits 
of a sparse index and improve user experience, we need to optimize the 
compatibility and teach git to only expand the sparse directory entries 
only when needed. 

###Plan

Every integration will have similar steps, but the actual steps of commands
 integrated for the project will vary based on the complexity of the commands 
 chosen:

(Notice that step 1 is from ShaoXuan's GSoC 2022 Git Contributor Proposal, 
and steps 2,4-7 are from GSoC 2023 Ideas. I made some additions to the steps.)

1. Investigation around a Git command and see if it behaves correctly with 
sparse-checkout. Modify the Git command's logic to work better with 
'sparse-checkout'. Add corresponding tests.[3]

    *Step 1 does not often occur. But it is important to ensure 
    *"sparse-checkout" is compatible with the Git command to continue 
    *with  the next step.

2. Add tests to t1092-sparse-checkout-compatibility.sh for the built-in, 
with a focus on what happens for paths outside of the sparse-checkout cone.


    t1092-sparse-checkout-compatibility.sh create a repository with some 
    data shapes in it. Each test case starts by copying that repository into 
    three new repositories with different configurations. These three are called 
    'full-checkout'  , 'Sparse-checkout' , and 'Sparse-index', respectively :

    'full-checkout' is the same as the repository, without sparse-checkout.

    'Sparse-checkout' with cone mode sparse-checkout enabled.

    'Sparse-index'  with cone mode sparse-checkout and sparse index enabled. 

    Add tests for the git command we want to integrate with sparse-index to 
    t1092 without the code change. Focus on the git command, which has the 
    ability to affect full-checkout/sparse-checkout/sparse-index differently.
    The test case should run against all three repositories and have the same 
    output and it should also work when the index is expanded. After integrating 
    the git command with sparse-index, the output and behavior should remain 
    the same.  


3. Add performance tests, so we have a baseline to measure how
   well the git command does.

    We need a baseline to measure the speed before integrating the git command 
    with sparse-index. Normally we will notice the speed is quite slow caused
     by expanding the index.



4. Disable the command_requires_full_index setting in the built-in and 
ensure the tests pass.

5. If the tests do not pass, then alter the logic to work with the 
sparse index.

    Make the code change to only expand the sparse directory entries only 
    when needed.command_requires_full_index setting guards all index reads 
    to require a full index over a sparse index.

    After suitable guards are placed in the codebase around uses of the index, 
    remove the setting. 

6. Add tests to check that a sparse index stays sparse.

    Add  ensure_not_expanded test to t1092-sparse-checkout-compatibility.sh,
    We expect the index to be expanded for out-of-cone moves. But we need to 
    ensure the index will not expand for in-cone moves.

7. Run performance tests to demonstrate speedup.


###Project Timeline


#Empty Period (Present - May 4)

    My end-semester exams begin on April 4 to  April 28. Hence I might be 
    a bit busy in this period.

    After April 28, I will continue to work on 'git diff-files' and start 
    to work on ' git describe '

#Community Bonding Period (May 4- May 28) 

    Get familiar with the community

    I have read the related documentation about 'Sparse Index Integrations'
    and working on 'git diff-files' , one of the builtins that could be 
    integrated with the sparse index. The feedback and the advice for 
    improvement make me learn a lot. And I'm confident I can start the project 
    at the start of this period.

    Keep working on "git diff-files' and  'git describe' on May 5, and the 
    expected time of completion of these two is May 28.


#Phase 1 (May 29 -July 9)

    week 1 to week 3  (May 29-June 18): integrate  'git write-tree' with 
    sparse index. Use the steps above.

    week 4 to week 6(June 19 -July 9 ): integrate  'git diff-index' with 
    sparse index,use steps above.

#Phase 2 (July 9 - August 28)

    week 1 to week 3  (July 9 - July 23): integrate  'git diff-tree' with 
    sparse index. Use the steps above.

    week 4 to week 6 (July 23 - August 13 ): integrate 'git worktree' with 
    sparse index. Use the steps above.

    week 7(August 13-August 28) :
    A buffer of one week has been kept for any covert difficulties when 
    integrated with the sparse index.

###Blogging about Git

When I was a freshman, I hated writing summaries or other learning materials.
But then I started writing blogs for new knowledge to keep track of what 
I've learned. I realized that When I  dive into a topic and want to write it 
down, I  will think much deeper about it than just learning. I also learned a 
lot and gained many skills from others' blogs. I would love to write about my 
progress and experiences with the project. In this way, I could share the ideas 
with those interested in researching this project and help them get up to speed more quickly.



###Availability

My semester will complete in late April, leaving me enough time to prepare 
for my GSoC project. Git is the only project for my summertime. If I am 
selected, I shall be able to work five days per week, 7 - 8 hours per day, 
around 35 -40 hrs a week on the project, though I am open to putting in more 
effort if the work requires. If everything is going well with the plan, I may 
want to Participate in a hackathon for a few days with my friends in July.


###Post GSoC


I have received much support from many members of the Git community in recent 
months. This support has strengthened my passion for git and inspired me to 
contribute more of my code to the community. Just as others have helped me, 
I will pay it forward by assisting and encouraging new community members. I 
believe that sharing knowledge and collaborating with others is the key to 
creating great software and achieving success in the open-source world.

I am committed to delivering high-quality work and meeting the expectations 
of the community. I am eager to learn from experienced community members and 
gain new skills and knowledge that will help me become a more valuable 
contributor. I am eager to continue working with the Git community beyond the
scope of the GSOC program. I believe I have much to offer the community, 
and I am committed to contributing to its success for a long time.

I hope that the Git community will consider my application for the GSOC 
program. It would be an honor to be able to contribute to such a fantastic 
open-source project and work with such a supportive and welcoming community. 
Thank you for your time and consideration.



###References

[1] Bring your monorepo down to size with sparse-checkout.
 https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/

[2] Make your monorepo feel small with Git’s sparse index. 
https://github.blog/2021-11-10-make-your-monorepo-feel-small-with-gits-sparse-index/


[3]Step 1 in the plan is come from  shaoxuan’s proposal in 2022
https://docs.google.com/document/d/1VZq0XGl-wCxECxJamKN9PGVPXaBhszQWV1jaIIvlFjE/edit

Thanks & Regards,
Shuqi
