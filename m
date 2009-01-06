From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 resend] git.c: make autocorrected aliases work
Date: Tue, 06 Jan 2009 00:19:09 -0800
Message-ID: <7v7i58kfsy.fsf@gitster.siamese.dyndns.org>
References: <1231089128-12066-1-git-send-email-dato@net.com.org.es>
 <1231089361-12619-1-git-send-email-dato@net.com.org.es>
 <20090104172833.GA7139@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>,
	git@vger.kernel.org
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:20:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7B1-0007rh-VS
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbZAFITR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZAFITQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:19:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZAFITP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:19:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D9EC98DEA5;
	Tue,  6 Jan 2009 03:19:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EB1338DEA4; Tue,
  6 Jan 2009 03:19:10 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B47AC198-DBCA-11DD-AE46-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104657>

Alexander Potashev <aspotashev@gmail.com> writes:

>> @@ -479,31 +501,22 @@ int main(int argc, const char **argv)
>> ...
>> +		was_alias = run_argv(&argc, &argv);
>> +		if (errno != ENOENT)
>>  			break;
>> +		if (was_alias) {
>>  			fprintf(stderr, "Expansion of alias '%s' failed; "
>>  				"'%s' is not a git-command\n",
>>  				cmd, argv[0]);
>>  			exit(1);
>
> Why not using 'die' here?

The code is in the context, and I do not think it is a good idea to
conflate such a change to a patch that wants to add aliases auto
correction.

While I do not think it matters too much in practice (unless existing
scripts that runs git depends on the exact error status value), there are
two differences: the message will say "fatal: " in front, and the command
exits with 128 not with 1.
