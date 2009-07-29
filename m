From: Josh ben Jore <jbenjore@whitepages.com>
Subject: Re: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Date: Wed, 29 Jul 2009 13:45:00 -0700
Message-ID: <C69602DC.61D6D%jbenjore@whitepages.com>
References: <20090729161030.GA3848@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jul 29 22:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWG1V-0003O4-0G
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 22:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096AbZG2UpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 16:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756045AbZG2UpD
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 16:45:03 -0400
Received: from mail0.w3data.com ([38.112.225.178]:64329 "EHLO
	hub.corp.w3data.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756019AbZG2UpB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 16:45:01 -0400
Received: from post.corp.w3data.com ([172.18.0.206]) by hub ([172.25.0.29])
 with mapi; Wed, 29 Jul 2009 13:45:07 -0700
Thread-Topic: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Thread-Index: AcoQZyZA6JyF3jubSsuXuzgSRirShQAJkpqV
In-Reply-To: <20090729161030.GA3848@localhost>
Accept-Language: en-US
Content-Language: en
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124387>

On 7/29/09 9:10 AM, "Clemens Buchacher" <drizzd@aon.at> wrote:
> Hi,
> 
> On Tue, Jul 28, 2009 at 03:23:00PM -0700, Josh ben Jore wrote:
> [...]
>>   CONFLICT (rename/add): Rename
>> config/conf/target/dev-ubuntu/wpn_rails/appserver.yml->config/conf/target/dev
>> /wpn_rails/appserver.yml
>> in Temporary merge branch 1. config/conf/target/dev/wpn_rails/appse2
>>   Adding as config/conf/target/dev/wpn_rails/appserver.yml~Temporary merge
>> branch 2 instead
>>   Skipped config/conf/target/dev/wpn_rails/appserver.yml (merged same as
>> existing)
> [...]
>>   There are unmerged index entries:
>>   2 config/conf/target/dev/wpn_rails/appserver.yml
>>   3 config/conf/target/dev/wpn_rails/appserver.yml
>>   Merging:
>>   virtual merged tree
>>   e4a886b Adding legacy click log processing scripts
>>   found 1 common ancestor(s):
>>   09fb055 Merge commit 'rel_090630_prod_02'
>> Segmentation fault
> 
> Yeah, if process_entry leaves unmerged entries, write_tree_from_memory will
> return NULL. I can reproduce with the following script (same principle as
> t7405).
> 
> Clemens
> ---
> 
> diff --git a/t/t6035-merge-recursive-ra.sh b/t/t6035-merge-recursive-ra.sh
> new file mode 100755

Thank you for the unit test. It fails as expected but I didn't verify that
it failed with the segfault as I'm experiencing. Your explanation of "There
are unmerged index entries:" is interesting. I've taken that as the focal
point for working around the bug in my repo with the unfixed software.

I've also started getting acquainted with the code in merge_tree to see if I
can identify the problem. I do not understand the se_stage values of 0 vs 2
or 3. These are not defined as constants or documented in the code. I'm
viewing them as magic for now. :-/

Josh
