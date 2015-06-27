From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sat, 27 Jun 2015 10:32:10 +0200
Message-ID: <vpq7fqppn5h.fsf@anie.imag.fr>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<CAP8UFD0Zzjcc94qcUJOpfSrTej-o6hRKzZOuTufzAbOPkjUr_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 10:32:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8lXS-0001fw-0X
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 10:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbbF0Icd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 04:32:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54011 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbbF0Ic1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 04:32:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5R8WAj1028837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 27 Jun 2015 10:32:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5R8WAhR022650;
	Sat, 27 Jun 2015 10:32:10 +0200
In-Reply-To: <CAP8UFD0Zzjcc94qcUJOpfSrTej-o6hRKzZOuTufzAbOPkjUr_A@mail.gmail.com>
	(Christian Couder's message of "Sat, 27 Jun 2015 06:51:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 27 Jun 2015 10:32:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5R8WAj1028837
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435998735.18709@fEqwlW5CSfcGlvMBB2u+ZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272854>

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Jun 27, 2015 at 6:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Fri, Jun 26, 2015 at 9:10 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>>
>>> If we don't want to support positional arguments, then I would suggest
>>> supporting first the following instead:
>>>
>>>          git bisect terms --name-good=fast --name-bad=slow
>>>          git bisect terms --name-bad=slow --name-good=fast
>>>
>>> This would make the interface consistent with the code.
>>
>> Which somewhat defeats the point of introducing "old" and "new", though.
>> The "terms" support is for people who feel that good/bad would be too confusing
>> for the particular bisect session (e.g. because they are hunting for a fix).
>
> Well if --name-old and --name-new are also available as synonyms, it
> would not be too bad I think.
> People could use the option names that fit their mental model or their
> use case better.

OK, I'll add both.

>>>> We may want to start supporting
>>>>
>>>>         git bisect start --new=master --old=maint
>>>
>>> Maybe we could also support:
>>>
>>> git bisect start --name-good=fast --name-bad=slow --fast=maint --slow=master
>>
>> The same comment for the token after --name-, but allowing the terms to be set
>> at "start" could be a type-saver.  With need for added "--name-"
>> prefix (worse, twice),
>> I am not sure if it would be seen as a useful type-saver, though.
>
> At least people don't need to remember if they have to use "git bisect
> term" before or after starting :-)

OK, first lesson learnt: the UI is controversial. So, I'm working on a
series that splits the last patch into several preparation steps, and a
very simple patch to implement the UI.

I have a draft here https://github.com/moy/git/commits/bisect-terms
I'll go through it once more and send it later.

As a teaser, the patch implementing the UI is just:

--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -70,6 +70,26 @@ bisect_autostart() {
 	}
 }
 
+parse_name_args() {
+	while [ $# -gt 0 ]; do
+		arg="$1"
+		case "$arg" in
+		--name-good|--name-old)
+			shift
+			must_write_terms=1
+			NAME_GOOD=$1
+			shift ;;
+		--name-bad|--name-new)
+			shift
+			must_write_terms=1
+			NAME_BAD=$1
+			shift ;;
+		*)
+			shift ;;
+		esac
+	done
+}
+
 bisect_start() {
 	#
 	# Check for one bad and then some good revisions.
@@ -88,6 +108,9 @@ bisect_start() {
 	else
 		mode=''
 	fi
+	# Parse --name-* options before the other to allow any mix of
+	# --name-* and revisions on the command-line.
+	parse_name_args "$@"
 	while [ $# -gt 0 ]; do
 		arg="$1"
 		case "$arg" in
@@ -98,6 +121,8 @@ bisect_start() {
 		--no-checkout)
 			mode=--no-checkout
 			shift ;;
+		--name-good|--name-old|--name-bad|--name-new)
+			shift 2 ;;
 		--*)
 			die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 		*)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
