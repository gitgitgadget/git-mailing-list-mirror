From: karthik nayak <karthik.188@gmail.com>
Subject: [RFC][GSOC] Proposal Draft for GSoC, Suggest Changes
Date: Thu, 20 Mar 2014 22:06:18 +0530
Message-ID: <CAOLa=ZRdxHz8VVT+iRaNSrj=EdpAFO2kjOhJ-++S9hODwDFmGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 17:36:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQfxa-0001eX-14
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 17:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759351AbaCTQgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 12:36:45 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:53214 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146AbaCTQgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 12:36:41 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so1173953pab.8
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=7RQzja3QV8zAUJ8UFt3e5OzEFu32DAwDN33+JVSXNes=;
        b=h2hLcHfWXrhr6KGeIzgrqpz7thq8E8r5ppCwC2jWaQ0Rl7O0+Qk53SdCuDSCwk439v
         gqF446cxayYNUxy4OzK7Q2OXMwHrbMSkxMyAf9JOM08PplnnpIN/42xN+7xc/1DPJi9Y
         6IwBJMyDexC5s3NV/ncqy2cs/yN3bUzRI2fivH0A/S+BHDTvQOu5rrPs53wTPDSL2FsU
         NnDh1oOxLlUzKueO6IbTPxicNrgh6a/fWjkin7BH85BBpld5L6G+wKjFY72NWM7guE22
         nklRvIR4g2hP/d0n+1BgJ2s3AiqO5cTyXk9hmvmmSAxKO3kFPR+6lE7RfU58BnpwHuRV
         klZA==
X-Received: by 10.68.235.6 with SMTP id ui6mr46635516pbc.45.1395333398849;
 Thu, 20 Mar 2014 09:36:38 -0700 (PDT)
Received: by 10.68.189.2 with HTTP; Thu, 20 Mar 2014 09:36:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244554>

Hello,
I have completed my microproject under the guidance of Eric, After
going through the code and
previous mailing lists. I have drafted my Proposal. Still going
through the code
as of now and figuring things out. Would be great to have your
suggestions on my proposal, so that i can improve it before submitting
it. Also have written the proposal in markdown for easier formatting.
Doesn't look pretty on plain text.
Thanks
Karthik


Git configuration API improvements

Abstract

Currently git_config() has a few issues which need to be addressed:

Reads and parses the configuration files each time.
Values cannot be unset,only can be set to false which has different
implications.
Repeated setting and un-setting of value in a particular new header,
leaves trails.

This project is to fix these problems while also retaining backward
compatibility
wherever git_config() is called, by implementing a cache for the config's in a
tree data structure, which provides for easier modification.

About Me

Name : Karthik Nayak
Email : Karthik.188@gmail.com
College : BMS Institute of Technology
Studying : Engineering In Computer Science
IRC : nayak94
Phone : 91-XXXX-XXX-XXX
Country : India
Interests : Guitar, Photography, Craft.
Github : KarthikNayak

Technical Experience

Have been Learning about the Linux Kernel and its implementation on the android
platform. Released also on XDA-Dev for the phones LG P500 and Xperia SP.
Working on a Library in C on various Sorting Techniques.
Contributed to the Open-Source Lab Manual for Colleges under VTU.
Active Member of Gnu/Linux Users Group in College and Free Software
Movement of Karnataka.

Why i Picked Git

This is my first attempt at GSOC and as I began going through the list
of organisations, what struck me is that
I haven't really used any of the software's of most of the listed
organisations. That's when I realized why
not contribute to something I use on a daily basis, this way I wont be
contributing only because I want to take
part in GSOC, rather I'd contribute because I would love to be a part
of something I use on a regular basis
and would be able to contribute to the project even after GSOC.

Proposal

Ideas Page : Git configuration API improvements

The Following improvements have to be made to how configs are handled in git :

Read all the config files once and store them in an appropriate data structure.

I suggest the use of an tree data structure to store the cache of the
config files.
I think tree data structure is a better choice over a hash - key data
structure as a tree data
structure although has a lower time efficiency than a hash - key data
structure while traversing
for a config request. A tree data structure can more optimal for
further improvements like
the problem with setting and unsetting of configs can be easily
handled as when a node under
a particular header is deleted the header can check if it has no
children nodes and on being true
can delete the header from the config file.

Change git_config() to iterate through the pre-read values in memory
rather than re-reading
the configuration files. This function should remain
backwards-compatible with the old implementation
so that callers don't have to all be rewritten at once.

Now whenever git_config() is called within a single invocation of git
it can traverse the
tree data structure already created and get the particular config.
This needs to maintain backward
compatibility. So the Basic functioning of functions like git_config()
and so on would change the
API should remain the same for the user invoking these calls.

Add new API functions that allow the cache to be inquired easily and
efficiently.
Rewrite callers to use the new API wherever possible.

Now that the base data structure and underlying changes have been made
for the data structure
to work have been made, we can now add various new API functions to
assist the usage of the data
structure. And also rewrite callers to use the new API's made available

Issues to be addressed

Headers and comments left are all configs under a header is deleted.

whenever we set and unset configs under a particular header it leaves
garbage value
behind, for example :

git config pull.rebase true
git config --unset pull.rebase
git config pull.rebase true
git config --unset pull.rebase

would result in :

[pull]
[pull]

And further changes made appear under the last header.
The issue also gives rise to comments being stranded within a header.

Possible Solution :

Make sure that the header is deleted whenever the last config under it
is deleted.
Also delete comments within a header and comments made above a particular config
when a config is removed and comments made above a header when the whole header
is being removed.

How to invalidate the cache correctly in the case that the
configuration is changed
while git is executing.

If config is being changed while git is currently running then the
changes need to be considered.

Possible Solution :

A simple solution would be to discard the whole cache made and when an
invocation is
made the cache, is rebuilt again. Else we can find a way to update
only the changed config
although this would be a harder implementation.

Timeline

Before Coding Starts

Week 1 : Discuss the flow of course with the mentor.
Week 2-3 : Discuss the adequate Data Structure for caching config values.
Week 4 : Discuss on changing of git_config() to correspond to the new
Data Structure.

Coding Starts

Week 1-2 : Submit Code for a new data structure. This will cache the
config after its been read the first
and this is stored as per to provide backward compatibility.
Week 3-5 : Make git_config() iterate over the new data structure when
it is called, and make sure it is
backward compatible, until changes have been made to the calling functions.

Mid Term Evaluation

Week 6-11 : Add new API functions to allow integration and allow to
retrieve configuration
as per the data type (string, bool, int ... etc).
Week 11-12 : Small changes and cleaning up and fix for duplication of
Config Header after config
being deleted.
Week 13 : Final Cleanup and Mentor suggested final touches to be made.

Pen Down Date

Submission of Code to GSOC
