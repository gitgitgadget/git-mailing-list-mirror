From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sat, 03 Jan 2009 21:30:37 -0800
Message-ID: <7vvdsv3af6.fsf@gitster.siamese.dyndns.org>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org>
 <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matt Kraai" <kraai@ftbfs.org>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 06:32:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJLap-0002lI-Ob
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 06:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbZADFar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 00:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750698AbZADFaq
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 00:30:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbZADFaq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 00:30:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3CA308DE9D;
	Sun,  4 Jan 2009 00:30:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 561168DE9C; Sun,
  4 Jan 2009 00:30:39 -0500 (EST)
In-Reply-To: <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com>
 (demerphq@gmail.com's message of "Sat, 3 Jan 2009 17:18:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4A4C51E-DA20-11DD-95D6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104495>

demerphq <demerphq@gmail.com> writes:

> 2009/1/3 Matt Kraai <kraai@ftbfs.org>:
> [...]
>> -sub feature_blame {
>> -       my ($val) = git_get_project_config('blame', '--bool');
>> +sub feature_bool {
>> +       my $key = shift;
>> +       my ($val) = git_get_project_config($key, '--bool');
>>
>>        if ($val eq 'true') {
>>                return 1;
>
> Maybe that should be:
>
>            return ($val eq 'true');
>
> as It is not a good idea to use 0 as a replacement for perls false, as
> the two have different behaviour.

I'd rather want to keep our scripts free of deep Perl magic.  Even if
there are SVs that are interpreted as false other than 0, that does not
necessarily mean you have to fear that 0 can sometimes evaluate to true.

As long as you refrain from doing something crazy like "0 but true",
people who are not (and/or are not inclined to become) familiar with the
gory innards of Perl can rely on 0 being false and 1 being true when
calling feature_something subs, no?
