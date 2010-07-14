From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH/RFC 1/4] Allow creation of arbitrary git-shell commands
Date: Wed, 14 Jul 2010 13:42:49 -0400
Message-ID: <AANLkTimAkSB1bysyE6R3CWp-U3vk_S5L0CbMhIWXJfHE@mail.gmail.com>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
	<1279076475-27730-2-git-send-email-gdb@mit.edu>
	<7vbpaaytfl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 19:43:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ5z1-0002nY-SW
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064Ab0GNRmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 13:42:54 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:58508 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753902Ab0GNRmy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 13:42:54 -0400
X-AuditID: 12074425-b7b12ae0000009fd-51-4c3df71ded08
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id 4C.25.02557.D17FD3C4; Wed, 14 Jul 2010 13:42:53 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o6EHgqCk030744
	for <git@vger.kernel.org>; Wed, 14 Jul 2010 13:42:53 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6EHgnJM000782
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 14 Jul 2010 13:42:52 -0400 (EDT)
Received: by wwi17 with SMTP id 17so2294577wwi.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 10:42:49 -0700 (PDT)
Received: by 10.227.156.11 with SMTP id u11mr12681519wbw.146.1279129369394; 
	Wed, 14 Jul 2010 10:42:49 -0700 (PDT)
Received: by 10.227.129.16 with HTTP; Wed, 14 Jul 2010 10:42:49 -0700 (PDT)
In-Reply-To: <7vbpaaytfl.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAhUsEmsVLC1f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151021>

>> This provides a mechanism for the server to expose custom
>> functionality to clients. =A0My particular use case is that I would =
like
>> a way of discovering all repositories available for cloning. =A0A
>> client that clones via
>> =A0 git clone user@example.com
>> can invoke a command by
>> =A0 ssh user@example.com $command
>
> Please have a blank line above and below sample command display like =
these
> for readability.
Sounds good.

>> + =A0 =A0 /* Shell should be spawned with cwd in the git user's home=
 directory */
>> + =A0 =A0 if (chdir(COMMAND_DIR))
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("unrecognized command '%s'", prog);
>
> Hmm, could you justify "should be" above please?
>
> An example would be "All of the custom commands I wrote to give added
> features to users at my installation wanted to be in that directory, =
not
> at the user's home directory, as they mostly operated on files in tha=
t
> directory", but please do not make me (or other reviewers) guess why.
>
> What I am getting at is that it may be more natural and useful to run
> these custom commands in the user's $HOME directory---you would need =
to
> make sure that execl() finds the command you get from the request, pe=
rhaps
> by prefixing COMMAND_DIR / to the command name, though.
Err, good point.  The commands I wrote end up running 'cd ..' anyway
:).  Instead just running these commands in the user's $HOME does make
a lot more sense.

Thanks everyone for the comments thus far.
