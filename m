From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH v2 03/21] t/test-lib-functions.sh: generalize test_cmp_rev
Date: Sun, 24 Apr 2016 21:51:39 +0200
Message-ID: <571D23CB.8020305@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
 <1460294354-7031-4-git-send-email-s-beyer@gmx.net>
 <xmqqd1pqbq2a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 21:51:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auQ4Q-0003Pi-Kc
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 21:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbcDXTvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 15:51:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:63120 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbcDXTvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 15:51:48 -0400
Received: from [192.168.178.43] ([92.76.229.135]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MLvGW-1amkYy3du8-007i0i; Sun, 24 Apr 2016 21:51:40
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
In-Reply-To: <xmqqd1pqbq2a.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:AXHqjYyNPRlrRYi3ViEHm+XIwN8PxNBAvrjPgEvb5SF0C7XsbV3
 vfYmMXB1tpBfK/T0mJy7s5MZ05pX4Q6vQjN2KRkqnUO+7a8W9RppW7TEvJ3f5M+Nq+JBi+h
 PTpUhZrLEHBgTjF8WVICsa9soM0dcbJVghMLWRsfkSApptakbUmJ+AAKu6d1Svg8ipk6Iqy
 iXT5sajp2w3nYMC2WUcWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0lszYIarFWc=:uBIFtvh672G/hFhDS3EhB0
 Vr61oUhDIKZ3iW529v4YTq8rLyPNpJnM8ClP2f2NzaB9jQjZQFXPCsdNj/xjW2G3nNz9vlRkA
 NdH9Gch50cJo7fDMIRSVn2ZpAi4pDJxbTc9MpHKzPAPc3lgqoq4i8ErhuGOVzKpdNrLvHw4a8
 fwUNmzGKxK5ShzGHzn2SlYQdKuQPAgKwsJ8WTpn0d+5l9h6B1RjnG8Q81yJtrwfNUJTHGOVv3
 GsogGY9L6gH8m4INX8GTEn0ZvhAVkLHVTnta7NR2wexYfvFrWRtR0UpCChHiHL3VveB7+Q21K
 VLFoaU0aD2XF4nxv9AFEHHiDmAqks+MDpQrw0etT/hzWgcpYB0hQw0c+TLM3Kp9I7mzSfurBa
 w7MAPYLgFy6IIBMzIPZzac6jAl1FWm8OMDgl2B043ezzsKB8KCekI76xujJ2+As0UVT0DIqZ7
 szZSosoJZBlUdkWzYLhelzZbVwXBRrHmk8hKLTXErY+KrjJcxD3ZYj/hbZJSEU7fDGPdkTT1p
 0b3AhU2K7cgrYhTI+nicPowcza0hNwd1RHjE7aLcurwFmDWDKZV67mw4hd74u2rgZuWghrfAT
 wWvJoxW2lZ9vdMJBtmXlghIJdN30iiISAGH7UhhFdzT73/1zosCEB+TN8tTW7gxTJTx7mNjr/
 elcgsNuecTtivTya5c1HUUAoUADmoUL9lEyxo81DjUjmyLXyNckuyo91qdpOUdFi04Gt3hBZD
 kYSCbnrKQcujjKoOPMNn6RxNPtlTmt0VDl+Meda4/IXbeH3Kem4Xyu8B86I+MWt3S/xm0tYm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292435>

Hi,

On 04/15/2016 10:00 PM, Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> 
>> test_cmp_rev() took exactly two parameters, the expected revision
>> and the revision to test. This commit generalizes this function
>> such that it takes any number of at least two revisions: the
>> expected one and a list of actual ones. The function returns true
>> if and only if at least one actual revision coincides with the
>> expected revision.
> 
> There may be cases where you want to find the expected one among
> various things you actually have (which is what the above talks
> about; it is like "list-what-I-actually-got | grep what-i-want"),
> but an equally useful use case would be "I would get only one
> outcome from test, I anticipate one of these things, all of which is
> OK, but I cannot dictate which one of them should come out" (it is
> like "list-what-I-can-accept | grep what-I-actually-got").

I see that these are strictly speaking (slightly) different semantics
but in the end it boils down to be the same, or am I missing anything?

> I am not enthused by the new test that implements the "match one
> against multi" check only in one way among these possible two to
> squat on a very generic name, test_cmp_rev.
> 
> The above _may_ appear a non-issue until you realize one thing that
> is there to help those who debug the tests, which is ...
> 
>> While at it, the side effect of generating two (temporary) files
>> is removed.
> 
> That is not strictly a side effect.  test_cmp allows you to see what
> was expected and what you actually had when the test failed (we
> always compare expect with actual and not the other way around, so
> that "diff -u expect actual" would show how the actual behaviour
> diverted from our expectation in a natural way).

I was referring to *generating the files* as a side effect. I did not
even think about the fact that "diff" in the original code does not only
return an exit code but that it also generates output that can be used
as "helpful diagnostic information" (referring to Eric Sunshine's mail
here). I was not aware that the Git tests should -- besides testing --
already include "tools" for easier debugging in case of a failure... So
dropping this information was not intentional.

> Something with the semantics of these two:
> 
> 	test_revs_have_expected () {
>         	expect=$1
> 		shift
> 		git rev-parse "$@" | grep -e "$expect" >/dev/null && return
> 		echo >&2 "The expected '$1' is not found in:"
>                 printf >&2 " '%s'\n", "$@"
>                 return 1
> 	}
> 
> 	test_rev_among_expected () {
> 		actual=$1
>                 shift
> 		git rev-parse "$@" | grep -e "$actual" >/dev/null && return
> 		echo >&2 "'$1' is not among expected ones:"
>                 printf >&2 " '%s'\n", "$@"
>                 return 1
> 	}
> 
> might be more appropriate.

Ah! That's what I meant above. The code is copy&paste besides variable
naming and the output "title". Such code duplication for the sake of
"easier debugging" in case of a failure?

Also I wonder if test authors in the future would really know *which*
one is the right one to use. In the end, either one of these two will
just be used arbitrarily (and I wouldn't even think there's anything bad
about it, because it *is* the same logic). I think this distinction is
like having two algorithms doing the same but with a different name.
Something you do NOT really want.

So I'd vote against a distinction of these two "cases", but I have no
problem with re-adding "debug" information (like you did in your code
examples).

Thanks!
Stephan
