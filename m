From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [WIP/PATCH v3] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Fri, 20 Jun 2008 14:08:04 +0200
Message-ID: <200806201408.05254.jnareb@gmail.com>
References: <1213487844-685-1-git-send-email-LeWiemann@gmail.com> <1213931911-15860-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 14:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9fQS-0006cx-NH
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 14:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYFTMIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 08:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYFTMIN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 08:08:13 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:15368 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbYFTMIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 08:08:11 -0400
Received: by an-out-0708.google.com with SMTP id d40so279590and.103
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5wy3CZ3Hdxb3CHKydG9bIG92oZ5cSGkpvej7aDYseJo=;
        b=WOBH8Rre40uylp8mXoEIQAY5KzF43OAR8CagSUodaPw+zZZb+5/pCLDcefW9kaF6AR
         EoSdwwlSQ/BDzp+ZKoL9mrZDnjLguzvSC61snOM7k6lJEeSpecNS7J0WlBYqirIO8xv/
         Tyz62ZfmNFCUbLU9X2EVfWt/azHlpKjURNB54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xi5LAHmb76iUAT5qDwq7ToTmy4GFpmtpQ5RmgQpE/Tv6UdXwL2Gex67BtyelYLy5VU
         WHTBjV2tKIZbzwEe4X1hx+OnCJdCzoBoSKelaoNJiRJ5ULS8BWU6pwHBzrdDXdB5DlNF
         dfDQg9bUgb85qXgkrHocvSLeV2tYiwoLvUmi8=
Received: by 10.100.33.13 with SMTP id g13mr5286351ang.96.1213963690491;
        Fri, 20 Jun 2008 05:08:10 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.51])
        by mx.google.com with ESMTPS id c9sm3699826ana.9.2008.06.20.05.08.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 05:08:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1213931911-15860-1-git-send-email-LeWiemann@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85627>

On Fri, 20 Jun 2008, Lea Wiemann wrote:

> From: Jakub Narebski <jnareb@gmail.com>

If you have rewritten the patch I won't mind if you change authorship
to you (remove this From: line); signoff is IMHO enough.

> ---
> I haven't gotten around to merging Jakub's recent XML validation patch
> yet, but I think it'd be good to have some review now; I'll merge it
> tomorrow and send another patch.

First, it is not XML validation[*1*], but check if XML is well-formed.
Second, I think it would be better if adding XML checks (RSS, Atom,
OPML) would be left as separate commit.
 
[*1*] There is W3C feed validation service, http://validator.w3.org/feed/
which provides also standalone Python script for feed validation, and
also SOAP interface with WebService::Validator::Feed::W3C wrapper (but
it would require having Internet connection), or we can try validate
against XML Schema Definition (there exists one for RSS, and there is
one for Atom derived from Relax-NG schema).

> diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
[...]
> +# set up test repository
> +test_expect_success 'set up test repository' '
[cut]

I have created this part as a copy of older t9500 gitweb test, thinking
about what we might want to test, but the WIP of Mechanize based t9503
doesn't have yet tests for those specific features.

> diff --git a/t/t9503/test.pl b/t/t9503/test.pl
[...]
> +# We don't count properly when skipping, so no_plan is necessary.
> +use Test::More qw(no_plan);

Actually it is not that we cannot could properly when skipping, because
there are two ways to have skipped tests and test count upfront, both
implemented in my initial version (v1) of t/t9503/test.pl.

You can set number of tests upfront depending if some feature is
available, e.g. "plan tests => <n> - $use_lint*<m2> - $check_xml*<m2>"
or just "if ($use_lint) { plan tests => <m> } else ...".

Or you can explicitly skip tests using SKIP: BLOCK (see Test::More(3pm)).


What we have here is that we don't know number of tests upfront,
because it is complicated, and that's what I'd like to see in the
comment instead (but I don't have idea for exact wording).

> +my @revisions = map { substr $_, 0, 10 } split /\s/, `git-rev-list --first-parent HEAD`;

Why do you use shortened SHA1 identifier, instead of full SHA1? Links
in gitweb use full SHA1.

> +my $head = $revisions[-1];

Errr, HEAD would be $revisions[0], $revisions[-1] would be $root.

> +my $gitweb = File::Spec->catfile('..','..','gitweb','gitweb.cgi');
> +# the followin two lines of code are workaround for bug in
> +# Test::WWW::Mechanize::CGI::cgi_application version up to 0.3
> +# (http://rt.cpan.org/Ticket/Display.html?id=36654)
> +# for pathnames with spaces (because of "trash directory")
> +$gitweb = File::Spec->rel2abs($gitweb);
> +$gitweb = Cwd::abs_path($gitweb);
> +
> +my $mech = new Test::WWW::Mechanize::CGI;
> +$mech->cgi_application($gitweb);

Another solution would be to copy relevant parts of cgi_application
(without all the checks for example), and use $mech->cgi( sub { ... } );
here (without the cgi_application bug).

> +our $baseurl = "http://localhost";
> +our($params, $url, $pagedesc, $status);

I think we can use 'my' here; gitweb uses 'our' only to be able to run
it correctly as "legacy CGI" mod_perl script.

> +our($params, $url, $pagedesc, $status);

Style: I would write "our (", with space between keyword and opening
parenthesis.

> +# test_page ( <params>, <page_description>, <expected_status> )
> +# Example:
> +# if (test_page '?p=.git;a=summary', 'repository summary') {
> +#     $mech->...;
> +#     $mech->...;
> +# }

Style: I would use function call form, i.e. "test_page(...)", not
command-like (or script-like) form.


As to the rest of the test: I think as preliminary test it is a good
thing to have.  We can think about what tests to add later (unless you
rather have exhaustive test suite now...).

-- 
Jakub Narebski
Poland
