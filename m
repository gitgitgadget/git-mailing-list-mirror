From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH 1/4] Allow creation of arbitrary git-shell commands
Date: Wed, 21 Jul 2010 11:11:10 -0400
Message-ID: <AANLkTiktvRmx-2iSVCTvrDYrAAw0kGCtsBhb1mg1ULbx@mail.gmail.com>
References: <1279602972-1264-1-git-send-email-gdb@mit.edu>
	<1279602972-1264-2-git-send-email-gdb@mit.edu>
	<7vr5iym6jj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j.sixt@viscovery.net, git@vger.kernel.org, avarab@gmail.com,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 17:11:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObaxB-0002Nx-NH
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 17:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab0GUPLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 11:11:17 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:47881 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131Ab0GUPLP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 11:11:15 -0400
X-AuditID: 1209190d-b7c82ae000000a16-ff-4c470e13b500
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Brightmail Gateway) with SMTP id CF.EF.02582.41E074C4; Wed, 21 Jul 2010 11:11:16 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o6LFBD5R018546
	for <git@vger.kernel.org>; Wed, 21 Jul 2010 11:11:13 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6LFBBf0004663
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 21 Jul 2010 11:11:12 -0400 (EDT)
Received: by wwj40 with SMTP id 40so2445621wwj.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 08:11:11 -0700 (PDT)
Received: by 10.227.146.213 with SMTP id i21mr300215wbv.99.1279725070836; Wed, 
	21 Jul 2010 08:11:10 -0700 (PDT)
Received: by 10.216.137.228 with HTTP; Wed, 21 Jul 2010 08:11:10 -0700 (PDT)
In-Reply-To: <7vr5iym6jj.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAhVGFDQVRtIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151397>

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user_argv[0] =3D prog;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 execv(user_argv[0], (char =
*const *) user_argv);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(prog);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(user_argv);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* split_cmdline modifies its argument i=
n-place, so 'prog' now
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* holds the actual command name
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("unrecognized command '%s'", prog_cpy)=
;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* split_cmdline has clobbered prog and =
printed an
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* error message, so print the original
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("invalid command format '%s'", prog_cp=
y);
>
> Hmm, we might want to fix split_cmdline to report the breakage better
> then (perhaps not as part of this patch series). =A0Instead of seeing
>
> =A0 =A0error: cmdline ends with \.
> =A0 =A0fatal: invalid command format 'foo bar \'.
>
> wouldn't it be nicer to see a single error message:
>
> =A0 =A0fatal: invalid command 'foo bar\': cmdline ends with \.
>
That would definitely be preferable.  If possible, I would rather not
do it as part of this patch series, but would be happy to work on
fixing split_cmdline afterwards.
