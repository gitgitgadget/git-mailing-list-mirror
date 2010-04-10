From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH v2 3/3] send-email: Add sendemail.smtpdomain
Date: Sat, 10 Apr 2010 09:51:36 -0400
Message-ID: <503EF023-77C0-4763-947C-385C67D3875A@gernhardtsoftware.com>
References: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com> <1270827245-28958-4-git-send-email-brian@gernhardtsoftware.com> <201004092040.50142.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 15:51:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0b6K-0001UM-6c
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 15:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab0DJNvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 09:51:40 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35290 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0DJNvj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 09:51:39 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 0D3A91FFC058; Sat, 10 Apr 2010 13:51:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.97] (unknown [64.134.103.20])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id B4FFD1FFC056;
	Sat, 10 Apr 2010 13:51:34 +0000 (UTC)
In-Reply-To: <201004092040.50142.jnareb@gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144548>


On Apr 9, 2010, at 2:40 PM, Jakub Narebski wrote:

> On Fri, 9 Apr 2010, Brian Gernhardt wrote:
> 
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index f491d44..bdfe3f2 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -132,8 +132,7 @@ my $have_email_valid = eval { require Email::Valid; 1 };
>> my $have_mail_address = eval { require Mail::Address; 1 };
>> my $smtp;
>> my $auth;
>> -my $mail_domain_default = "localhost.localdomain";
>> -my $mail_domain;
>> +my $smtp_domain_default = "localhost.localdomain";
> 
> Why this change, this renaming of variables from $mail_domain_default
> and $mail_domain to $smtp_domain_default and $smtp_domain?  Why you
> have removed this forward declaration of $smtp_domain/$mail_domain?

I changed it to better match many of the other variables in the script.  The variables that hold command line options are usually named after the option.  I left the default there as this seemed to be an area of the script that set "constant" variables (like $have_email_valid and $have_mail_address).

>> sub unique_email_list(@);
>> sub cleanup_compose_files();
>> @@ -190,7 +189,7 @@ sub do_edit {
>> # Variables with corresponding config settings
>> my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
>> my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
>> -my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
>> +my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, $smtp_domain);
>> my ($validate, $confirm);
>> my (@suppress_cc);
> 
> Why have you moved $smtp_domain declaration (formerly $mail_domain)
> here?  And why it is not described in commit message (at least "Cleanup.",
> or something like this)?

$smtp_domain moved here to match comment just above "Variables with corresponding config settings".  $mail_domain was up near some unrelated globals and I wanted to move it near other similar variables.

Yes, all of this should have been in my commit message.  I blame the hour I was originally coding.  I had intended to fix my Python problem and send it in, but then I had to fix send-email because my MTA complained about "EHLO My-Computer".

I appreciate the review and help, although I wish I wasn't making a fool of myself in public.  ;-)

~~ Brian Gernhardt