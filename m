From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCH 2/3] Test environment of git-remote-mw
Date: Fri, 01 Jun 2012 16:43:13 +0200
Message-ID: <4FC8D501.20207@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr> <1338547317-26088-1-git-send-email-guillaume.sasdy@ensimag.imag.fr> <1338547317-26088-2-git-send-email-guillaume.sasdy@ensimag.imag.fr> <vpqmx4n9rq6.fsf@bauges.imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	git@vger.kernel.org, Charles Roussel <charles.roussel@ensimag.fr>,
	Simon Perrat <Simon.Perrat@ensimag.imag.fr>,
	Charles Roussel <Charles.Roussel@ensimag.imag.fr>,
	Julien Khayat <Julien.Khayat@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 01 16:43:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaT4R-0006Kz-4X
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 16:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759066Ab2FAOnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 10:43:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46423 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759031Ab2FAOnN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 10:43:13 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q51EYjql011846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jun 2012 16:34:45 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q51Eh8Hi011286;
	Fri, 1 Jun 2012 16:43:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <vpqmx4n9rq6.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 01 Jun 2012 16:34:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q51EYjql011846
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339166087.08959@27sEYvB6g6S2cwbKbchhSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198991>

On 01/06/2012 13:49, Matthieu Moy wrote:
> Guillaume Sasdy<guillaume.sasdy@ensimag.imag.fr>  writes:
>
>>   # CONFIGURATION VARIABLES
>> -# You might want to change those ones ...
>> +# You might want to change these ones
>>   #
>>   WIKI_DIR_NAME=3D"wiki"            # Name of the wiki's directory
>>   WIKI_DIR_INST=3D"/var/www"        # Directory of the web server
>>   TMP=3D"/tmp"                      # Temporary directory for downlo=
ads
>> -                                # Absolute address needed!
>> +                                # Absolute path required!
>>   SERVER_ADDR=3D"localhost"         # Web server's address
>>
>> -#
>>   # CONFIGURATION
>> -# You should not change those ones unless you know what you to
>> +# You should not change these ones unless you know what you do
> I already mentionned in in your v1, but these fixups do not belong to
> PATCH 2/3. You do not want reviewers to see your mistakes in PATCH 1/=
2
> and see the fix in PATCH 2/3.
Got it. With the problem experienced yesterday, we had still this issue=
=20
this morning. It is now fixed :).
>> +wiki_getpage () {
>> +	../test-gitmw.pl get_page -p "$1" "$2"
>> +}
> Any reason why test-gitmw.pl and wiki_getpage have this slightly
> different API? The perl version has a "-p" flag, and the shell comman=
d
> has only positionnal arguments.
The "-p" flag exists to specify if we have to use the admin login on=20
wiki to do the command. For instance, here we fetch a page from the wik=
i=20
with Admin privilege.
Others arguments remains the same.
> I'd rather have a more uniform way to wrap calls to test-gitmw.pl in
> shell, like
>
> wiki_<something>  () {
> 	../test-gitmw.pl<something>  "$@"
> }
Do you suggest we include the "-p" flag in <something> ?
I agree for the use of "$@".
>
> Then, you probably want to move the API documentation (i.e. comments =
you
> put before the shell functions) in, or next to the Perl script, and
> avoid repeating it in the shell.
>
Ok.
>> +# git_content<dir_1>  <dir_2>
>> +#
>> +# Compare the contents of directories<dir_1>  and<dir_2>  with diff
>> +# and exits with error 1 if they do not match. The program will
>> +# not look into .git in the process.
>> +git_content () {
> Didn't I already say that the naming was strange? A function that
> compares something shouldn't be called just "content".
Sorry, we misunderstood what you mean... Update is coming. What about=20
git_diff_directories ?
Because this shell function execute a special instance of diff, matchin=
g=20
two directories and ignoring blank character.
>> +	result=3D$(diff -r -b --exclude=3D".git" "$1" "$2")
>> +
>> +	if echo $result | grep -q ">" ; then
> Why grep, when the exit status of diff tells you about the difference=
s
> already?
>
Good idea for the exit status.
>> +# git_exist<rep_name>  <file_name>
>> +#
>> +# Check the existence of<file_name>  into the git repository
>> +#<rep_name>  and exits with error 1 if it is absent.
>> +git_exist () {
>> +	result=3D$(find "$1" -type f -name "$2")
>> +
>> +	if ! echo $result | grep -q "$2" ; then
> Missing quotes around $result.
>
> Why do you need grep again? You just want to check whether "$result" =
is
> empty (test -z).
this function is now erased from our code... Actually, it was really=20
useless...
>> +		echo "test failed: file $2 does not exist in $1"
>> +		exit 1
> die
>
> ?
>
>> +wiki_page_exist () {
>> +	wiki_getpage "$1" .
>> +
>> +	if test -f "$1".mw ; then
>> +		echo "test failed: file $1 not found on wiki"
>> +		exit 1
> likewise.
We were supposed to do it with the previous version.
But we are facing some difficulties using die function outside the test=
=20
harness. We wanted to include the file "test-lib.sh" in our own script=20
"test-gitmw-lib.sh" to use die. It doesn't work, because the harness=20
expect the file "test-gitmw-lib.sh" to be a test script. Wich is not th=
e=20
case.

Do you have any Idea about how to fix this problem ?
>> +fail()
>> +{
> Style: fail () {
>
> Plus, didn't we say "die" was already there for this?
Agree, see above.
>> +        # Replace spaces by underscore in the page name
>> +	$pagename=3D~s/\ /_/;
> Indent with space (didn't I already mention that?).
>
>> +my $login =3D $ARGV[0];
>> +
>> +if ($login eq "-p")
> Feels weird. If you're not sure it's a login, why call the variable
> $login?
Change on the way. renaming this variable "is_login". Is this ok for yo=
u ?
> Any reason not to use Perl's option parsing?
Not at all, we juste didn't thought about it.

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
