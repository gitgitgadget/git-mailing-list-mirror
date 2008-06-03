From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 14:03:47 +0200
Message-ID: <b77c1dce0806030503r55c95d73t5ff244821f76cf1@mail.gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
	 <m34p8a2173.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 14:04:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3VFq-00056l-Kv
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 14:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbYFCMDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 08:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbYFCMDt
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 08:03:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:14696 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623AbYFCMDs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 08:03:48 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1544485rvb.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1H9k3QBBgsEBhZX//U5FmozMqLLmqM5Z+d99Ejky40g=;
        b=N9yP0L5J/tRbaAnS+eXLUx6WvFcmNJxu6WQV2VuDnATYEvdjgqgLoBzpRp61461C6iqE4gYsFcZP3DfEX3M3EE+UZaEzvgGR+Oa7KX4UYTvuNvXQrgNI0bpX9ACePWnVFu/Ri8ma/1/mRpXNxxWOLRtabbrEJQOQPP0DuK2sVwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SMz3WNzDol8zs56EQlPyPV+ic3kz37ms1CHXb+1CWTkWNyHfRLHluypZljefBy8OSufMXQFiwQtKMP878YdxXbzsywezhISc2CQihAwNZv9f5o7kt2Z90zyJuslgkRsLZWQvADlqlSwyiv922cAvrZcswEKL3a7IzCnyW2Ixsdk=
Received: by 10.141.33.21 with SMTP id l21mr5689581rvj.105.1212494627757;
        Tue, 03 Jun 2008 05:03:47 -0700 (PDT)
Received: by 10.141.178.21 with HTTP; Tue, 3 Jun 2008 05:03:47 -0700 (PDT)
In-Reply-To: <m34p8a2173.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83645>

2008/6/3 Jakub Narebski <jnareb@gmail.com>:
>> -             open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
>> +             open (my $dd, "-|", git_cmd(), "rev-parse", '--revs-only', "$full_rev^")
>>                       or die_error(undef, "Open git-rev-parse failed");
>> -             my $parent_commit = <$dd>;
>> +             my $parent_commit = <$dd> || '';
>>               close $dd;
>>               chomp($parent_commit);
>>               my $blamed = href(action => 'blame',
>
> I'd rather remove this, correct it, or make it optional (this is very
> fork-heavy).

Not sure how to do the same thing in pure perl.
We could however cache the results of git-rev-parse, since the same
rev is likely to appear many times in the list.
