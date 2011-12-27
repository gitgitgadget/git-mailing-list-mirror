From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] switch to central prompt method
Date: Tue, 27 Dec 2011 12:47:48 -0800
Message-ID: <7vpqf968sr.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ECEF.6020403@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Dec 27 21:47:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfdwD-00028r-K2
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 21:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab1L0Urw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 15:47:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60208 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925Ab1L0Uru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 15:47:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B2A07EC5;
	Tue, 27 Dec 2011 15:47:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=QPiUyyY1AA0AIRT0gRDW+5qgUHQ=; b=oklKFdV+3AgKiJCWNzP6
	T49TwYd1wMU+Etk3s3LeD05n0ThuPEIRvx0E/srHlsP8vYhEoRBkR2p8BGfRMmAt
	93Yjrlbhg5RfQKCspdfmChsiIG/JvQ1lZcUHYqj5LoZ3/vEuBSIECGK/x46DZExW
	0yDSWQlv0diE6Slo1HDpIVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hUHQEyoqshIYyVPOOV+OXW7ASCOAtSk8N2Pi5ht2uCPZYN
	3A2Sq8e9d9w/JknKJ6Oq4AlUkC2GdvogbtFh6XaTHnts6bRAE3884dMFH9vF68aR
	ZYeN0MA2ttMWU2gDfz7lUZ81svxzyNvFcrmqvdDuP5xZQoY2n4RqCjmhFX/vU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 126B57EC4;
	Tue, 27 Dec 2011 15:47:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92DB47EC3; Tue, 27 Dec 2011
 15:47:49 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09F1C7C6-30CC-11E1-9B1A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187727>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---

It would be better to have this and the previous patch squashed into one
commit, for three reasons:

 - It is far easier to review the patch that way, because it will show the
   old way to get the password from the user as the removed code and new
   way to do so as the added helper function, enabling reviewers to
   compare the two in a single review session, to see if the change keeps
   the feature bug-to-bug compatible, introduces any regression, and/or
   offers improvements over existing code.

 - If there were a bug in the implementation of askpass_prompt method
   introduced in patch 1 without being used, and the calling codepath
   introduced in patch 2 is bug-free (i.e. it correctly follows the
   calling convention of the new method, only the implementation of the
   method is buggy), bisection will still point at patch 2 that dumped the
   old proven working way and started using the buggy new implementation.

   Of course, it is possible that patch 1 perfectly implements the new
   method and a bug exists in the way the caller introduced in patch 2
   calls the method and in such a case bisection will correctly point out
   that the caller is at fault, but the point of this refactoring is to
   make it harder for callers to make such mistakes.

 - As we can see above the three-dash line, even the author of the series
   could not come up with any justification why the proposed change is a
   good thing in the proposed commit log message for this patch alone (or
   the previous patch alone for that matter). Combining these patches
   together would make it clearer why it may be a good thing, which would
   make it easier to come up with a better log message.

>  git-svn.perl |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index eeb83d3..25d5da7 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4415,13 +4415,8 @@ sub username {
>
>  sub _read_password {
>  	my ($prompt, $realm) = @_;
> -	my $password = '';
> -	if (exists $ENV{GIT_ASKPASS}) {
> -		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
> -		$password = <PH>;
> -		$password =~ s/[\012\015]//; # \n\r
> -		close(PH);
> -	} else {
> +	my $password = Git->askpass_prompt($prompt);;
> +	if (!defined $password) {
>  		print STDERR $prompt;
>  		STDERR->flush;
>  		require Term::ReadKey;
