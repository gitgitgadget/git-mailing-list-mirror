From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2009, #03; Thu, 20)
Date: Fri, 21 Aug 2009 20:06:12 +0200
Message-ID: <200908212006.16333.jnareb@gmail.com>
References: <7veir5naq3.fsf@alter.siamese.dyndns.org> <F4C7A2F3-B030-449A-87AC-B54CA2B647B4@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Aug 21 20:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeYVb-0002HR-Ac
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 20:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbZHUSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 14:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbZHUSG3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 14:06:29 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64625 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbZHUSG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 14:06:28 -0400
Received: by fxm17 with SMTP id 17so595808fxm.37
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=a9KMeMkMwnNFnhyekNz9L4loYem4FFIAWd+us2T2tGI=;
        b=u45Qld0qYjHNnhBoppmSUb3FZw96/4azW4UnyQay5vZr99OYZAkDhXfcvcVlQWROSl
         joQwUIwe973sbgRNGEX1bLCs3/HM44LCSPYA+srKDci6bMeZZNzY68siwvWWZ6zTE52z
         2EhmM2JiVL27yO7Borvdl/vu+uVMDegDMK/yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pB+3Ri8SeJ3GnP5UgT+flwZbnERrAerktzOQKFiPZypQvX8e5KrWRPuna1KB+c3+TJ
         CS11YuwNoG/6yaAKQMOq5v7UOgNzXHF8xmhXwp8alQyuDs00u5UfjABIEabGiJ811Z3o
         SLsz8PutSJeVFCTv7/vZwE8V7J+aIW7aczPc8=
Received: by 10.86.187.27 with SMTP id k27mr1094042fgf.11.1250877988812;
        Fri, 21 Aug 2009 11:06:28 -0700 (PDT)
Received: from ?192.168.1.13? (abwo198.neoplus.adsl.tpnet.pl [83.8.238.198])
        by mx.google.com with ESMTPS id 12sm3935461fgg.25.2009.08.21.11.06.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 11:06:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <F4C7A2F3-B030-449A-87AC-B54CA2B647B4@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126739>

On Fri, 21 Aug 2009, Mark A Rada wrote:
> On 20-Aug-09, at 10:48 PM, Junio C Hamano wrote:
> 
> > Should graduate to 'master' soon.
> >
> > * mr/gitweb-xz (2009-08-06) 3 commits
> >  (merged to 'next' on 2009-08-14 at b63b8e6)
> > + gitweb: add support for XZ compressed snapshots
> > + gitweb: update INSTALL regarding specific snapshot settings
> > + gitweb: support to globally disable a snapshot format
> >
> 
> 
> I never submitted any tests for the patch that adds global snapshot  
> disabling functionality to gitweb.
> 
> Jakub, I changed the gitweb_run routine to capture STDOUT as well, 
> is that ok?

I think it is a good addition to the gitweb tests in git testsuite,
as it might make finding cause of an error easier.

> Unless I missed a case, the tests show that the extra condition check  
> that was added in the git_snapshot() routine is never actually
> executed, because a disabled snapshot format is not added to
> @snapshot_fmts, which is checked first.
> 
> snippet:
> 5178     } elsif (!grep($_ eq $format, @snapshot_fmts)) {
> 5179         die_error(403, "Unsupported snapshot format");
> 5180     } elsif ($known_snapshot_formats{$format}{'disabled'}) {
> 5181         die_error(403, "Snapshot format not allowed");
> 5182     }
> 5183

So we did check if format is disable twice, once when creating
(generating @snapshot_fmts list, and once (I guess unnecessary;
@snapshot_fmts is generated after reading GITWEB_CONFIG file(s)) 
when checking if snapshot $format is on the list of possible 
(allowed) formats in the snipped above.

Am I right?  If it is so, the last part of above snipped wouldn't
be ever exercised, and is not necessary.

> ---
>   t/t9500-gitweb-standalone-no-errors.sh |   67 +++++++++++++++++++++++ 
> ++++++++-

Word-wrapped.

>   1 files changed, 66 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb- 
> standalone-no-errors.sh
> index 6275181..9ce9667 100755
> --- a/t/t9500-gitweb-standalone-no-errors.sh
> +++ b/t/t9500-gitweb-standalone-no-errors.sh
> @@ -57,10 +57,11 @@ gitweb_run () {
>   	# we are interested only in properly formatted errors/warnings
>   	rm -f gitweb.log &&
>   	perl -- "$SCRIPT_NAME" \
> -		>/dev/null 2>gitweb.log &&
> +		>gitweb.output 2>gitweb.log &&
>   	if grep "^[[]" gitweb.log >/dev/null 2>&1; then false; else true; fi
> 
>   	# gitweb.log is left for debugging
> +	# gitweb.output is used to parse output
>   }

This is a good change.

> 
>   . ./test-lib.sh
> @@ -704,4 +705,68 @@ test_expect_success \
>   	 gitweb_run "p=.git;a=summary"'
>   test_debug 'cat gitweb.log'
> 
> +
> +#  
> ----------------------------------------------------------------------
> +# snapshot settings
> +
> +cat >>gitweb_config.perl <<EOF
> +
> +\$feature{'snapshot'}{'override'} = 0;
> +EOF

A trick: use '\EOF' and you don't need to escape $ against variable
expansion by shell.

  +cat >>gitweb_config.perl <<\EOF
  +
  +$feature{'snapshot'}{'override'} = 0;
  +EOF

> +
> +test_expect_success \
> +	'snapshots: tgz only default format enabled' \
> +	'gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tgz" &&
> +	grep "Status: 200 OK" gitweb.output &&
> +	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=tbz2" &&
> +	grep "403 - Unsupported snapshot format" gitweb.output &&
> +	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=txz" &&
> +	grep "403 - Unsupported snapshot format" gitweb.output &&
> +	gitweb_run "p=.git;a=snapshot;h=HEAD;sf=zip" &&
> +	grep "403 - Unsupported snapshot format" gitweb.output'
> +test_debug 'cat gitweb.output'

I would prefer (but I do not require) that such test were placed in
separate file, named e.g. t9501-gitweb-check-http-status.sh, and leave
t9500-gitweb-standalone-no-errors.sh to be about checking for Perl 
errors and warnings only.  This would require to extract common 
infrastructure (gitweb_init, gitweb_run, checking prerequisites)
into t/lib-gitweb.sh (or t/gitweb-lib.sh ;-)).

-- 
Jakub Narebski
Poland
