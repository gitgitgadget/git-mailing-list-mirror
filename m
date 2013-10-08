From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-credential-netrc: fix uninitialized warning
Date: Tue, 08 Oct 2013 15:55:34 -0400
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87li23v8p5.fsf@flea.lifelogs.com>
References: <87zjqjx25g.fsf@flea.lifelogs.com>
	<20131008194147.GF9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 21:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTdNT-0007fq-5p
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 21:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab3JHTz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 15:55:26 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:40395 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab3JHTzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 15:55:25 -0400
Received: by mail-qa0-f43.google.com with SMTP id i13so797829qae.16
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lifelogs.com; s=google;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=Ute5YNvHeibf7QF3emiJHcC0onCUPIXLlKYbWDYt2U0=;
        b=Y6kLBTrZYyC27+WCWosETpw2U3fYBJdKGOc4a/AikeimgkZEzUeajWgiIYJZ1w/XYa
         8KUqrrxR889spjMG7yWjYJ8MEvtnIyAVlA/iIvRvKBHAtuaWkjdKgE/wQhqF7/d2digo
         HqpOX4CgtfxiYWd98kw4TjeVnnGKLVagpDnqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=Ute5YNvHeibf7QF3emiJHcC0onCUPIXLlKYbWDYt2U0=;
        b=Xy3z8c4CxRwxwlC3yUzPem0TEObEBDmEpd7F8PQXiB16FI2fsdarDmMjmerjPK6R46
         W3MAoXLdI+tEZNcRB2CxdtLy4ju9onQphh3xcanUPv1dXtuLFhSvcwzLzNe+a70POwAV
         3Kd6puD5lMPNMLew+RDycCGwn0OMIhZMnJPz8v3fwKK2ZU1KG1GKSuyt7v289WWQELbm
         R4A/6m9lyTpYSIgfIitj5xS1J0COpx7rYmUxOc5gBBkdRIchoD0S4T/oDhfv7FL0jdYn
         PHnA/Hfue+boDBVIxf9GOSdu7lekGmcSKzHedp4form1FEaBLNEQU/QxnN2FObm/6CrY
         rd8Q==
X-Gm-Message-State: ALoCoQneHUK1WamGxKhfOyybVWf1s63Smh7AWQ16REXZmCO59usbvqWlpgoBZhutxqP+Qen6iN4u
X-Received: by 10.49.2.68 with SMTP id 4mr4718066qes.64.1381262124794;
        Tue, 08 Oct 2013 12:55:24 -0700 (PDT)
Received: from flea.lifelogs.com (c-98-229-61-72.hsd1.ma.comcast.net. [98.229.61.72])
        by mx.google.com with ESMTPSA id h6sm67739694qej.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 12:55:23 -0700 (PDT)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <20131008194147.GF9464@google.com> (Jonathan Nieder's message of
	"Tue, 8 Oct 2013 12:41:47 -0700")
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235786>

On Tue, 8 Oct 2013 12:41:47 -0700 Jonathan Nieder <jrnieder@gmail.com> wrote: 

JN> Ted Zlatanov wrote:

>> Simple patch to avoid unitialized warning and log what we'll do.

JN> Sign-off?

I didn't realize it was a requirement, must I?

JN> [...]
>> --- a/contrib/credential/netrc/git-credential-netrc
>> +++ b/contrib/credential/netrc/git-credential-netrc
>> @@ -369,7 +369,10 @@ sub find_netrc_entry {
>> {
>> my $entry_text = join ', ', map { "$_=$entry->{$_}" } keys %$entry;
>> foreach my $check (sort keys %$query) {
>> -			if (defined $query->{$check}) {
>> +			if (!defined $entry->{$check}) {
>> +			       log_debug("OK: entry has no $check token, so any value satisfies check $check");
>> +			}
>> +			elsif (defined $query->{$check}) {

JN> Style: elsewhere this file seems to use cuddled elses:

JN> 	} elsif (...) {

Ah, thanks, I missed that.

JN> Or more simply, would it make sense to wrap both 'defined' checks into
JN> a single "if", like so?

JN> 		if (defined $entry->{$check} && defined $query->{$check}) {
JN> 			...
JN> 		} else {
JN> 			log_debug(...);
JN> 		}

I prefer the explicit version because we can issue a more precise
log_debug message.

Ted
