From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH] submodule: Improve documentation of update subcommand
Date: Mon, 02 Mar 2015 23:39:11 +0100
Message-ID: <87k2yzrpm8.fsf@steelpick.2x.cz>
References: <87egpgdaac.fsf@steelpick.2x.cz> <1424698360-10952-1-git-send-email-sojkam1@fel.cvut.cz> <xmqqvbiss7xb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 23:39:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSYzm-00086N-4S
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 23:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbbCBWjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 17:39:22 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:48779 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944AbbCBWjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 17:39:21 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 9063919F37C2;
	Mon,  2 Mar 2015 23:39:19 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id tvb7Yor2Av7o; Mon,  2 Mar 2015 23:39:17 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id B2B6719F37BF;
	Mon,  2 Mar 2015 23:39:17 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1YSYzX-0005hx-Pq; Mon, 02 Mar 2015 23:39:11 +0100
In-Reply-To: <xmqqvbiss7xb.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.19+54~g0747f5c (http://notmuchmail.org) Emacs/24.4.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264629>

On Mon, Feb 23 2015, Junio C Hamano wrote:
> Michal Sojka <sojkam1@fel.cvut.cz> writes:
>
>> The documentation of 'git submodule update' has several problems:
>
> Thanks, this round looks much better.
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index ae6791d..fb2ae37 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2411,12 +2411,17 @@ status.submodulesummary::
>>  
>>  submodule.<name>.path::
>>  submodule.<name>.url::
>> +	The path within this project and URL for a submodule. These
>> +	variables are initially populated by 'git submodule init';
>> +	edit them to override the URL and other values found in the
>> +	`.gitmodules` file. See linkgit:git-submodule[1] and
>> +	linkgit:gitmodules[5] for details.
>> +
>
> The sentence "edit them to override" talks about "other values",
> which in the original wanted to cover not just "path" but "update"
> as well.  By splitting 'update' into its own entry, "edit them to
> override" is lost from 'update'.
>
> But stepping back a bit, "edit them to override" applies to all
> configuration variables.  The user edits the configuration file to
> customize things.  I wonder if we even need to say this for .path
> and url in the first place?
>
>     Note: not a request to remove it because I hinted so, but a
>     request for comments and discussion, as I do not have a firm
>     opinion.

I also thing that "edit them to override" is kind of useless here so I
removed it.

>
>>  submodule.<name>.update::
>> -	The path within this project, URL, and the updating strategy
>> -	for a submodule.  These variables are initially populated
>> -	by 'git submodule init'; edit them to override the
>> -	URL and other values found in the `.gitmodules` file.  See
>> -	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
>> +	The default updating strategy for a submodule. This variable
>> +	is populated by `git submodule init` from the
>> +	linkgit:gitmodules[5] file. See description of 'update'
>> +	command in linkgit:git-submodule[1].
>
>
>
>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 8e6af65..067d616 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -154,27 +154,51 @@ If `--force` is specified, the submodule's work tree will be removed even if
>>  it contains local modifications.
>>  
>>  update::
>> -	Update the registered submodules, i.e. clone missing submodules and
>> -	checkout the commit specified in the index of the containing repository.
>> -	This will make the submodules HEAD be detached unless `--rebase` or
>> -	`--merge` is specified or the key `submodule.$name.update` is set to
>> -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
>> -	`--checkout`. Setting the key `submodule.$name.update` to `!command`
>> -	will cause `command` to be run. `command` can be any arbitrary shell
>> -	command that takes a single argument, namely the sha1 to update to.
>>  +
>> +--
>> +Update the registered submodules to match what the superproject
>> +expects by cloning missing submodules and updating the working tree of
>> +the submodules. The "updating" can be done in several ways depending
>> +on command line options and the value of `submodule.<name>.update`
>> +configuration variable. Supported update methods are:
>
> If you read the description of "--remote" (sorry, I didn't notice it
> until I formatted the result of this patch and tried to read the
> whole thing), we already use "update procedure" to mean these modes
> of updates collectively.  Either use "update procedures" here (and
> everywhere else in this patch where it is called "update method"),
> or adjust the existing "update procedure" to "update method".
> Either way is fine, but because "update procedure" is not wrong
> per-se, I think it would be better to use that phrasing that may
> already be familiar with the "git submodule" users.

OK, I replaced the method (and strategy in config.txt) with procedure.

In the previous version was also a typo, which is fixed now. v5 will
follow shortly.

Thanks.
-Michal
