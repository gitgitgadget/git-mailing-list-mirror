From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Tue, 22 Jul 2008 16:08:17 -0700
Message-ID: <7vsku1jz4u.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807222100150.8986@racer>
 <20080722203730.GC5113@blimp.local> <20080722210354.GD5113@blimp.local>
 <alpine.DEB.1.00.0807222207110.8986@racer>
 <20080722212633.GF5113@blimp.local>
 <alpine.DEB.1.00.0807222242160.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:09:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLQz0-0002Xh-AZ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbYGVXI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbYGVXI1
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:08:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbYGVXI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:08:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1711837E5D;
	Tue, 22 Jul 2008 19:08:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EF89A37E5C; Tue, 22 Jul 2008 19:08:21 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807222242160.8986@racer> (Johannes
 Schindelin's message of "Tue, 22 Jul 2008 22:44:50 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16E06132-5843-11DD-B32D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89557>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 22 Jul 2008, Alex Riesen wrote:
>
>> @@ -704,9 +707,10 @@ const char *help_unknown_cmd(const char *cmd)
>>  
>>  	if (!main_cmds.cnt)
>>  		die ("Uh oh.  Your system reports no Git commands at all.");
>> +	git_config(git_help_config, NULL);
>>  	best_similarity = similarity(main_cmds.names[0]->name);
>> -	if (main_cmds.cnt < 2 || best_similarity <
>> -			similarity(main_cmds.names[1]->name)) {
>> +	if (autocorrect && (main_cmds.cnt < 2 ||
>> +		best_similarity < similarity(main_cmds.names[1]->name))) {
>>  		if (!*cwd)
>>  			exit(1);
>>  		if (chdir(cwd))
>
> This "if" already checks if there is only one candidate.  So you should 
> just add an inner "if (autocorrect) ... else single = 1;" or some such.
>
> However, I think that the intention of this patch is too much DWIMery, 
> which might be good for me (just like my "git add remote" patch), but not 
> for the general audience.

Please make autocorrect not a binary but optionally the number of
deciseconds before it continues, so that I have a chance to hit ^C ;-)
