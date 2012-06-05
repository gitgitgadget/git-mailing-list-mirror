From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] Export file attachements in git-remote-mediawiki
Date: Tue, 05 Jun 2012 19:05:44 +0200
Message-ID: <vpq62b5g047.fsf@bauges.imag.fr>
References: <1338842961-3477-1-git-send-email-nguyenkimthuat@gmail.com>
	<vpqvcj6lq1m.fsf@bauges.imag.fr>
	<59db730bded272b60cbd16806c757660@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <roucherj@ensimag.imag.fr>,
	<Pavel.Volek@ensimag.imag.fr>
To: nguyenki <nguyenki@ensibm.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 19:05:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbxCb-0005lf-Vx
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 19:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab2FERFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 13:05:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48459 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606Ab2FERFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 13:05:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q55Gv9ES026729
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 18:57:09 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SbxCT-0005Zc-JE; Tue, 05 Jun 2012 19:05:45 +0200
In-Reply-To: <59db730bded272b60cbd16806c757660@ensibm.imag.fr>
	(nguyenki@ensibm.imag.fr's message of "Tue, 05 Jun 2012 19:00:01
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 05 Jun 2012 18:57:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55Gv9ES026729
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339520230.96804@HgIVInXwVmufbiaxMP6X4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199267>

nguyenki <nguyenki@ensibm.imag.fr> writes:

>>> @@ -642,8 +651,14 @@ sub mw_push_file {
>>>  	my $old_sha1 = $diff_info_split[2];
>>>  	my $page_created = ($old_sha1 eq NULL_SHA1);
>>>  	my $page_deleted = ($new_sha1 eq NULL_SHA1);
>>> +	my $file_deleted = ($new_sha1 eq NULL_SHA1);
>>
>> This line looks suspiciously similar to the previous one. Do you need
>> another variable for the same value?
> Yes, it's true. I just want the code to be more visible. Because, when
> we delete a file attachment, it's not a page wiki.

I still don't see a reason to have two variables for the same thing. If
$page_deleted is not a good name, then rename the variable to
something more general (e.g. $path_deleted ?)

>>> +	else {
>>> +		print STDERR "$complete_file_name is not supported on
>>> this version of Mediawiki.\n"
>>
>> It's not a matter of version, it's a matter of configuration.
> What do you think if i change it like:
>         else {
> 	print STDERR "$complete_file_name is not a permitted file
> type. Check your configuration for more information\n"

That's better, but it doesn't tell the user which configuration to
check (Git's one, or the wiki's one).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
