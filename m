From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH 1/2] rev list add option accepting revision constraints
 on standard input
Date: Wed, 06 Sep 2006 02:01:28 +0100
Message-ID: <44FE1DE8.1040200@shadowen.org>
References: <44FDECD1.2090909@shadowen.org>	<20060905215157.GA29172@shadowen.org> <7vpseaarrl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 03:02:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKloO-0007vp-Bz
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 03:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWIFBBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 21:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWIFBBy
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 21:01:54 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:784 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965130AbWIFBBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 21:01:52 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GKlnD-0004cZ-Mz; Wed, 06 Sep 2006 02:01:27 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpseaarrl.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26499>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> Add a --stdin flag which causes rev-list to additionally read
>> its stdin stream and parse that for revision constraints.
> 
>> +/*
>> + * Parse revision information, filling in the "rev_info" structure,
>> + * revisions are taken from stream.
>> + */
>> +static void setup_revisions_stream(FILE *stream, struct rev_info *revs)
>> +{
>> +	char line[1000];
>> +	const char *args[] = { 0, line, 0 };
>> +
>> +	while (fgets(line, sizeof(line), stream) != NULL) {
>> +		line[strlen(line) - 1] = 0;
>> +
>> +		if (line[0] == '-')
>> +			die("options not supported in --stdin mode");
>> +
>> +		(void)setup_revisions(2, args, revs, NULL);
>> +	}
>> +}
> 
> Is calling setup_revisions() on the same revs like this many
> times safe?  I do not think so, especially what is after the
> primary "for()" loop in the function.
> 
> I was sort-of expecting that you would instead replace that
> primary for() loop in setup_revisions() with some sort of
> callback...

Heh, well I'll give it another poke tommorrow my time ...

Thanks for the feedback.  Its hard to get any context on something new
without trying and failing :).

-apw
