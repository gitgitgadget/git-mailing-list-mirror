From: Glenn Rempe <glenn@rempe.us>
Subject: Re: [PATCH] Add ability to specify SMTP server port when using git-send-email.
Date: Tue, 25 Sep 2007 18:15:09 -0700
Message-ID: <1A0CAB9D-5C99-4FD7-B3AC-9B3161FD8663@rempe.us>
References: <1190759927-19493-1-git-send-email-glenn@rempe.us> <7vabra2rv3.fsf@gitster.siamese.dyndns.org>
Reply-To: glenn@rempe.us
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-3--138771678; protocol="application/pkcs7-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 03:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaLUq-00063C-Nd
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 03:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXIZBPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 21:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbXIZBPR
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 21:15:17 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:25235 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbXIZBPO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 21:15:14 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1863117rvb
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 18:15:13 -0700 (PDT)
Received: by 10.114.13.1 with SMTP id 1mr138820wam.1190769313062;
        Tue, 25 Sep 2007 18:15:13 -0700 (PDT)
Received: from ?192.168.0.22? ( [64.142.55.11])
        by mx.google.com with ESMTPS id v32sm133294wah.2007.09.25.18.15.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Sep 2007 18:15:12 -0700 (PDT)
In-Reply-To: <7vabra2rv3.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59203>


--Apple-Mail-3--138771678
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

ok, you're the boss! :-)

Comments:

>  * As you mentioned, ssmtp plus undocumented "server:port"
>    syntax never worked.  There is no point supporting the
>    combination.  Also I do not think it is worth additional
>    lines of code to even say "server:port" plus --server-port
>    option are not meant to be used together.

ok.  I'm new to Git and the project's coding standards.  I just  
thought that the additional check made the experience friendlier for  
the end user in the case of passing ambiguous arguments, even at the  
expense of a few lines of code.

>  * People who used the undocumented "server:port" syntax did not
>    use the new --smtp-server-port option anyway.

Likely true.

>
>  * If somebody goes over plain smtp specifies server without
>    port, we can let the Net::SMTP to handle the default port.
>    No need for _us_ to say that the default is 25.

ok.

>  * I do not see much point insisting that port to be numeric; I
>    do not know what Net::SMTP accepts, but if it accepts
>    my.isp.com:smtp instead of my.isp.com:25, that is fine. This
>    has the side effect of keeping people's existing set-up
>    working.

ok.  Again just trying to protect against invalid arguments.

>  * The indentation was horrible.  Maybe your tabstop is set
>    incorrectly?

Can you be more detailed on the definition of 'horrible'? :-) I am  
using Textmate on OS X with soft tab stops (2 spaces).  What should  
it be to look less horrible on your end?  Or is the issue that I  
indent fewer tabstops than you expect? If so, sorry since perl is not  
my usual language and Ruby 2 space (soft tab) indentation looks right  
to my eye.

>  * As I am inclined not to insist on numeric port numbers,
>    the additional tests become pointless.

ok.  Assuming you want to remove the check on port numbers.

> The result is much simpler, and I think it is more readable.
>

Back to my first comment.  I agree its more readable with less code.   
Just weighing the trade off with user experience.  The tool is a bit  
'sharper' in the hands of the end user now IMHO.

I hope this was helpful. :-)  Its been useful for me in getting to  
know Git and the community a bit better.  I'll assume you don't need  
me to do anything else on this issue?  If thats not correct please  
let me know.

Glenn


On Sep 25, 2007, at 5:27 PM, Junio C Hamano wrote:

> I'm inclined to do this on top of yours.
>
>  * As you mentioned, ssmtp plus undocumented "server:port"
>    syntax never worked.  There is no point supporting the
>    combination.  Also I do not think it is worth additional
>    lines of code to even say "server:port" plus --server-port
>    option are not meant to be used together.
>
>  * People who used the undocumented "server:port" syntax did not
>    use the new --smtp-server-port option anyway.
>
>  * If somebody goes over plain smtp specifies server without
>    port, we can let the Net::SMTP to handle the default port.
>    No need for _us_ to say that the default is 25.
>
>  * I do not see much point insisting that port to be numeric; I
>    do not know what Net::SMTP accepts, but if it accepts
>    my.isp.com:smtp instead of my.isp.com:25, that is fine. This
>    has the side effect of keeping people's existing set-up
>    working.
>
>  * The indentation was horrible.  Maybe your tabstop is set
>    incorrectly?
>
>  * As I am inclined not to insist on numeric port numbers,
>    the additional tests become pointless.
>
> The result is much simpler, and I think it is more readable.
>
> ---
>
>  git-send-email.perl   |   64 ++++++++++++ 
> +-----------------------------------
>  t/t9001-send-email.sh |   12 ---------
>  2 files changed, 18 insertions(+), 58 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 886f78f..62e1429 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -380,29 +380,6 @@ if (!defined $smtp_server) {
>  	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
>  }
>
> -# don't allow BOTH forms of port definition to work since we can't  
> guess which one is right.
> -if (($smtp_server =~ /:\d+/) && (defined $smtp_server_port)) {
> -  die "You must specify the port using either hostname:port OR -- 
> smtp-server-port but not both!"
> -}
> -
> -# setup smtp_server var if it was passed in as host:port format
> -if ( $smtp_server =~ /:\d+/) {
> -  # if they do pass a host:port form then split it and use the parts
> -  @smtp_host_parts = split(/:/, $smtp_server);
> -  $smtp_server = $smtp_host_parts[0];
> -  $smtp_server_port = $smtp_host_parts[1];
> -}
> -
> -# setup reasonable defaults if neither host:port or --smtp-server- 
> port were passed
> -if ( !defined $smtp_server_port) {
> -  if ($smtp_ssl) {
> -    $smtp_server_port = 465  # SSL port
> -  } else {
> -    $smtp_server_port = 25  # Non-SSL port
> -  }
> -}
> -
> -
>  if ($compose) {
>  	# Note that this does not need to be secure, but we will make a  
> small
>  	# effort to have it be unique
> @@ -632,39 +609,34 @@ X-Mailer: git-send-email $gitversion
>  	} else {
>
>  		if (!defined $smtp_server) {
> -		  die "The required SMTP server is not properly defined."
> -		}
> -
> -		if (!defined $smtp_server_port || !$smtp_server_port =~ /^\d+$/ ) {
> -		  die "The required SMTP server port is not properly defined."
> +			die "The required SMTP server is not properly defined."
>  		}
>
>  		if ($smtp_ssl) {
> +			$smtp_server_port ||= 465; # ssmtp
>  			require Net::SMTP::SSL;
> -			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port =>  
> $smtp_server_port );
> +			$smtp ||= Net::SMTP::SSL->new($smtp_server, Port =>  
> $smtp_server_port);
>  		}
>  		else {
>  			require Net::SMTP;
> -			$smtp ||= Net::SMTP->new($smtp_server . ":" . $smtp_server_port);
> +			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
> +						 ? "$smtp_server:$smtp_server_port"
> +						 : $smtp_server);
>  		}
>
> -    # we'll get an ugly error if $smtp was undefined above.
> -    # If so we'll catch it and present something friendlier.
> -    if (!$smtp) {
> -      die "Unable to initialize SMTP properly.  Is there something  
> wrong with your config?";
> -    }
> -
> -    if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
> -      $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp- 
> >message;
> -    }
> -
> -    $smtp->mail( $raw_from ) or die $smtp->message;
> -    $smtp->to( @recipients ) or die $smtp->message;
> -    $smtp->data or die $smtp->message;
> -    $smtp->datasend("$header\n$message") or die $smtp->message;
> -    $smtp->dataend() or die $smtp->message;
> -    $smtp->ok or die "Failed to send $subject\n".$smtp->message;
> +		if (!$smtp) {
> +			die "Unable to initialize SMTP properly.  Is there something  
> wrong with your config?";
> +		}
>
> +		if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
> +			$smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp- 
> >message;
> +		}
> +		$smtp->mail( $raw_from ) or die $smtp->message;
> +		$smtp->to( @recipients ) or die $smtp->message;
> +		$smtp->data or die $smtp->message;
> +		$smtp->datasend("$header\n$message") or die $smtp->message;
> +		$smtp->dataend() or die $smtp->message;
> +		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
>  	}
>  	if ($quiet) {
>  		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index d32907d..83f9470 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -41,16 +41,4 @@ test_expect_success \
>      'Verify commandline' \
>      'diff commandline expected'
>
> -test_expect_failure 'Passing in both host:port form AND --smtp- 
> server-port' '
> -  git send-email --from="Example <nobody@example.com>" -- 
> to=nobody@example.com --smtp-server smtp.foo.com:66 --smtp-server- 
> port 77" $patches 2>errors
> -'
> -
> -test_expect_failure 'Passing in non-numeric server port with  
> host:port form' '
> -  git send-email --from="Example <nobody@example.com>" -- 
> to=nobody@example.com --smtp-server smtp.foo.com:bar" $patches  
> 2>errors
> -'
> -
> -test_expect_failure 'Passing in non-numeric server port with -- 
> smtp-server-port form' '
> -  git send-email --from="Example <nobody@example.com>" -- 
> to=nobody@example.com --smtp-server smtp.foo.com --smtp-server-port  
> bar" $patches 2>errors
> -'
> -
>  test_done

--
Glenn Rempe
glenn.@rempe.us




--Apple-Mail-3--138771678
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGHTCCAtYw
ggI/oAMCAQICEC8uLU1P2+Tpg+Bhv9AucLEwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA2MTExMDAwNDAyOFoXDTA3MTExMDAwNDAy
OFowQDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEdMBsGCSqGSIb3DQEJARYOZ2xl
bm5AcmVtcGUudXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0L+jPtwJcbkzXNQqx
UqXSTj7L0bKqvY/C2dBiREQ31/NW80StAipIcIwxp1P16r6+M9O3DjRGiXxm75+c5O9lbxdHOmmm
HAusS6MG1pUL/o+PSME3NQ2MoEe1LM/f4TkyEJ2wsGqNSQKCkLVBbY2bqVGRt9LCmXeoAwrw5Rq1
fHTOMLXh3HX33Clf36nDCvXo6ZXaMrqCtzYmXloxyjFAudDb8MOpnhzc/IDjrUxMi0SEJHR9BSXR
1Q2Qsf5eo/XotLQmMRLiLJ1i7aqobmLaXOkLNKhwgpK9SvI1LnhiaBMP16LyKQYF5viESWJeCj04
qo+hMvK0og8w4CyDxNsBAgMBAAGjKzApMBkGA1UdEQQSMBCBDmdsZW5uQHJlbXBlLnVzMAwGA1Ud
EwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAqGi/0zvklNo4yN2zx3kA2p7eR936nv3RN+obLXWA
KKuAD3T7xYd/5H+VZD0JTa8QV/4maWbjwRRZRxapAL1Uwt9LPPqeSqBzykirq9FfFKDtL1ddEqdr
KOIJJjkxN2jCEeAHbDPDwd2MhVOZ5nZEpjrBQVj548MOGx6QhWMSR60wggM/MIICqKADAgECAgEN
MA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9D
ZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20w
HhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZ
Wh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuv
PAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBly
YLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRw
Oi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMC
AQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFh
YsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVN
d+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECEC8uLU1P2+Tpg+Bhv9AucLEwCQYFKw4DAhoFAKCCAW8wGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDcwOTI2MDExNTA5WjAjBgkq
hkiG9w0BCQQxFgQUNkM729yHEKfJm8CYGiwuvz3nJv8wgYUGCSsGAQQBgjcQBDF4MHYwYjELMAkG
A1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhAvLi1NT9vk6YPgYb/QLnCxMIGH
BgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0
aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5n
IENBAhAvLi1NT9vk6YPgYb/QLnCxMA0GCSqGSIb3DQEBAQUABIIBAFZN/rK+W/80IeGmkj9ABWvr
/Yg62B+f4pn7EVZSy3TimoiHv2D2VguG39ttQaKi+8knawALly0bY3pr6KnXArLEsAt1QGjVIK/D
TIXXxF+F7iVJX9LbgvwiAg4pfL5iE4WYNrgXsVmnv7eAvVXgPE/cJEA4hpKM0JPUacslguqrYTjQ
Mrg1NhJ2MKZWtSMgL/mFoQJXCGnciXprYfnunxk6+brXUoC6sw9o6mVO0FlHr5b+PClkij60QWa2
DsLqd4DHLH9s59bSO9aUE6FtUvwO1jcCZ7Hk6bd6rEyMXVy75BHxY7ukD5ItgxrYBSjXr2U8sN8Z
KzzZHc7ak/NvU4IAAAAAAAA=

--Apple-Mail-3--138771678--
