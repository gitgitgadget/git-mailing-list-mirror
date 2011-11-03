From: Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH] Add options to specify snapshot file name, prefix
Date: Thu, 03 Nov 2011 02:28:49 -0400
Message-ID: <4EB234A1.7090300@aei.ca>
References: <1320298641-11149-1-git-send-email-dermoth@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Guyot-Sionnest <dermoth@aei.ca>
X-From: git-owner@vger.kernel.org Thu Nov 03 07:35:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLqtp-0002SG-Sd
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 07:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab1KCGfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 02:35:33 -0400
Received: from mail001.aei.ca ([206.123.6.130]:51379 "EHLO mail001.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574Ab1KCGfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 02:35:33 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Nov 2011 02:35:32 EDT
Received: (qmail 31156 invoked by uid 89); 3 Nov 2011 06:28:51 -0000
Received: by simscan 1.2.0 ppid: 31153, pid: 31154, t: 0.0021s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mail002.contact.net) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 3 Nov 2011 06:28:51 -0000
Received: (qmail 23480 invoked by uid 89); 3 Nov 2011 06:28:51 -0000
Received: by simscan 1.2.0 ppid: 23464, pid: 23466, t: 0.8933s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.97.1/m: spam: 3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16)
X-Spam-Level: 
X-Spam-Status: No, hits=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from ppp-55-39.mtl.contact.net (HELO ?192.168.1.200?) (dermoth@216.221.55.39)
  by mail.aei.ca with ESMTPA; 3 Nov 2011 06:28:50 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Thunderbird/3.1.15
In-Reply-To: <1320298641-11149-1-git-send-email-dermoth@aei.ca>
X-Enigmail-Version: 1.1.2
OpenPGP: id=DE417216;
	url=http://pgpkeys.mit.edu:11371/pks/lookup?op=get&search=0xDE417216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184707>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Please disregard; i've actually managed to break the patch while playing
with it.

I will resubmit.

- --

Thomas

On 11-11-03 01:37 AM, Thomas Guyot-Sionnest wrote:
> commit b629275 implemented "smart" snapshot names and prefixes. I have
> scripts that used to rely on the old behaviour which allowed in some
> cases to have fixed prefix, and would require modifications to work with
> newer Gitweb.
> 
> This patch adds two parameters for overriding the snapshot name and
> prefix, sn and sp respectively. For example, to get a snapshot
> named "myproject.[suffix]" with no prefix one can add this query string:
>   ?sn=myproject;sp=
> 
> Signed-off-by: Thomas Guyot-Sionnest <dermoth@aei.ca>
> ---
>  gitweb/gitweb.perl |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..4820ef7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -756,6 +756,8 @@ our @cgi_param_mapping = (
>  	searchtext => "s",
>  	searchtype => "st",
>  	snapshot_format => "sf",
> +	snapshot_name => "sn",
> +	snapshot_prefix => "sp",
>  	extra_options => "opt",
>  	search_use_regexp => "sr",
>  	ctag => "by_tag",
> @@ -6684,6 +6686,12 @@ sub git_snapshot {
>  	}
>  
>  	my ($name, $prefix) = snapshot_name($project, $hash);
> +	if (defined($input_params{'snapshot_name'})) {
> +		$name = $input_params{'snapshot_name'};
> +	}
> +	if (defined($input_params{'snapshot_prefix'})) {
> +		$prefix = $input_params{'snapshot_prefix'};
> +	}
>  	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
>  	my $cmd = quote_command(
>  		git_cmd(), 'archive',


- -- 
Thomas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6yNJcACgkQ6dZ+Kt5BchZkCgCgvJ9kAF636HYCAwQ7LoWu8ckG
8+8Anj5ocii3c7vKQ2/eVjcAvDJxsvhQ
=jGwr
-----END PGP SIGNATURE-----
