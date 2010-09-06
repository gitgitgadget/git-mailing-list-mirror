From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] New send-email option smtpserveroption.
Date: Mon, 06 Sep 2010 14:13:51 -0700
Message-ID: <7vvd6itw1c.fsf@alter.siamese.dyndns.org>
References: <1283708940-2172-1-git-send-email-pascal@obry.net>
 <m3lj7fn9oy.fsf@localhost.localdomain>
 <7vpqwrv0l2.fsf@alter.siamese.dyndns.org>
 <201009061223.59090.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 23:14:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osj14-0005SW-U5
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 23:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab0IFVOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 17:14:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab0IFVOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 17:14:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C96DFD45A2;
	Mon,  6 Sep 2010 17:14:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fa48uE0ueSmwZFelccpm91C+87w=; b=vWMQ6N
	gD6twTNdyWwXr3kfNZQi8Dp7GNAX4Ezpt6CsyfScO1IrgHJooDLL/HmTYQ6M7Ksr
	wB5s9cySgl3O3lrUT3Ah1LFUQsEpRhSKPVrQLP3l1+UZSaRLjmFI0K5aRf4oId3J
	/H0mLecOmj7dPkr9bjKwEatJB4zQ8KpxCRKGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rr62pDjO71oU52Z04taNseHcF9NfGuf4
	MFOABfGeDg1YSaVtxcLSYWH1yML7GqTHURRQpPI/MDFjPB3epTV7QGZkkMndOiI3
	d+ulMl8pBRj4iO1V1D3qgIHRvvabPe1V3kQGxNrsyJpVnjdXvzbGBgykqq5UIrbQ
	9y/2J5o8qWg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 967BDD45A1;
	Mon,  6 Sep 2010 17:14:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 526F4D45A0; Mon,  6 Sep
 2010 17:13:54 -0400 (EDT)
In-Reply-To: <201009061223.59090.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon\, 6 Sep 2010 12\:23\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AB46FE82-B9FB-11DF-93E0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155624>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 6 Sep 2010, Junio C Hamano wrote:
> ...
>> And test if it is easy to arrange (otherwise I'll take a look myself, so
>> do not worry too much about it).
>
> Actually because *all* options use the same mechanism (%config_settings
> which is used in read_config, and GetOptions from Getopt::Long), it would
> be better to just test the mechanism, I think.
>
> But that is outside the scope of this patch...

I didn't mean a test that makes sure --sso=foo is parsed into @sso array;
that would be a _mechanism_ test you alluded to, but I think we probably
do not need such a test as long as  we trust Getopt::Long().

What I meant was to make sure that the result is correctly propagated to
the invocation of "exec($smtp_server, @sendmail_params)"; presumably the
check will use a custom $smtp_server command that checks individual
command line parameters.  And that _is_ exactly within the scope of this
change.
