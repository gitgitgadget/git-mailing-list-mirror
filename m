From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v7 07/10] send-email: reduce dependencies impact on
 parse_address_line
Date: Tue, 7 Jul 2015 11:37:47 +0200
Message-ID: <559B9DEB.9030409@web.de>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
 <1435666611-18429-8-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 07 11:38:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCPKH-0002Xy-4g
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 11:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbbGGJiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 05:38:00 -0400
Received: from mout.web.de ([212.227.17.11]:60182 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756608AbbGGJhw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 05:37:52 -0400
Received: from birne.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LgpVS-1Yi2JP0MYY-00oEIa; Tue, 07 Jul 2015 11:37:49
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <1435666611-18429-8-git-send-email-Matthieu.Moy@imag.fr>
X-Provags-ID: V03:K0:xCMcxnPpQL5K1ZpNDOZ85YVMTRjpaY7SCtOCAfVaBcfZnzAuK0U
 K6O+/RRENwkflo3bfuqZ2m7YfkHYRyGPT2wradZV5LwmSyD1ys3hx9viWkDyfaGCft38Cez
 NPX97F/9vRtrEkzocP2Qkb3a3/0+7U++qpkXVwwsJn+pje7QoWLa6y/kXHruk2HGEaOKDtS
 Ww0nq8vXcN09ZItzUs0dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ggBXGLMy1aE=:Z/dIxWV4zk0UWZlft9cdjt
 aD6fyaflEnx3lk0oakF5po77f0ihCLU7eROgCHdWjz7nTXuQOJ0ki2+y15nXcmYpvdR1fZClD
 PgTPydvZWa2iR1UHMfYMJZIq1hdDUeHU6uZXeIoG6LPmcHGA1z4M74TcdpA0W7LWA5hqDAZhY
 tQT1IZCa5MMe9795GeOctpDGv2Zd5V/s42kMYRnH6wyznblzDrHUDBH/HkWff4RuAnt+p3eH4
 G87K5vTiI20ZWfMnLYD4mRNWaNZwFaR2ZZrjKZjJmIitoM0/78QSjlWy1WVzkr38Gwf6ZFhLb
 3BvlHrepduxlvK2RjBKUoqgRQ+jIEZ3JTa6IlDra/SNtgnkpfACEVwh86Xc2vjknEQG/2dZfh
 7YWs5ERuKuRmbKu5VasL/DUlQwLor4WFcsPVp7FFpVh6PtbH5BTzPW93wTg83JUZ/p2rQgn7F
 YXKxPYHAvo5bLgtJKp9iPFeqzbqXO4bPEktJSXWaGtRvQeFzueOP3ISaJrELNd46lwEgd0W5a
 oghXPQ7c9mwVIysZwbEnAfuSMl3/nR3z7/AllgXa9KTx0U6Gn0hYkszGXpedj9nn4PAxs/ubu
 U/05lp9p+9GQx90HHgLSEU+vw2aRVqF+Bi8gz4UouVWhnfPRRrhqj58r0b7x7OxWl8AxxkKy4
 l6vOrQ7f3fwBw3jQhqruyoaSplBR70kpf9I6r6BCTAUF3cfTJqOe5nR1CgYtMTrLHBX8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273494>

#!/usr/bin/perl

Should we have hard-coded PATH to perl here ?

/usr/bin/perl --version
This is perl, v5.10.0 built for darwin-thread-multi-2level
(with 2 registered patches, see perl -V for more detail)

> +
> +my $is_passing = Test::More->builder->is_passing;
> +exit($is_passing ? 0 : 1);
> 

This seems to give problems:
debug=t verbose=t ./t9000-addresses.sh

Initialized empty Git repository in /Users/me/projects/git/git.pu/t/trash directory.t9000-addresses/.git/
# run 0: Perl address parsing function (perl /Users/me/projects/git/git.pu/t/t9000/test.pl)
ok 1 - use Git;
ok 2 - same output : Jane
ok 3 - same output : jdoe@example.com
ok 4 - same output : <jdoe@example.com>
ok 5 - same output : Jane <jdoe@example.com>
ok 6 - same output : Jane Doe <jdoe@example.com>
ok 7 - same output : "Jane" <jdoe@example.com>
ok 8 - same output : "Doe, Jane" <jdoe@example.com>
ok 9 - same output : "Jane@:;\>.,()<Doe" <jdoe@example.com>
ok 10 - same output : Jane!\#$%&'*+-/=?^_{|}~Doe' <jdoe@example.com>
ok 11 - same output : "<jdoe@example.com>"
ok 12 - same output : "Jane jdoe@example.com"
ok 13 - same output : Jane Doe <jdoe    @   example.com  >
ok 14 - same output : Jane       Doe <  jdoe@example.com  >
ok 15 - same output : Jane @ Doe @ Jane @ Doe
ok 16 - same output : "Jane, 'Doe'" <jdoe@example.com>
ok 17 - same output : 'Doe, "Jane' <jdoe@example.com>
ok 18 - same output : "Jane" "Do"e <jdoe@example.com>
ok 19 - same output : "Jane' Doe" <jdoe@example.com>
ok 20 - same output : "Jane Doe <jdoe@example.com>" <jdoe@example.com>
ok 21 - same output : "Jane\" Doe" <jdoe@example.com>
ok 22 - same output : Doe, jane <jdoe@example.com>
ok 23 - same output : "Jane Doe <jdoe@example.com>
ok 24 - same output : 'Jane 'Doe' <jdoe@example.com>
not ok 25 - same output : Jane\ Doe <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : Jane\ Doe <jdoe@example.com>'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '"Jane \ Doe" <jdoe@example.com>'
#     $expected->[0] = '"Jane\ Doe" <jdoe@example.com>'
not ok 26 - same output : "Doe, Ja"ne <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : "Doe, Ja"ne <jdoe@example.com>'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '"Doe, Ja" ne <jdoe@example.com>'
#     $expected->[0] = '"Doe, Ja ne" <jdoe@example.com>'
not ok 27 - same output : "Doe, Katarina" Jane <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : "Doe, Katarina" Jane <jdoe@example.com>'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '"Doe, Katarina" Jane <jdoe@example.com>'
#     $expected->[0] = '"Doe, Katarina Jane" <jdoe@example.com>'
not ok 28 - same output : Jane@:;\.,()<>Doe <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : Jane@:;\.,()<>Doe <jdoe@example.com>'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[1] = '\.'
#     $expected->[1] = '"\."'
not ok 29 - same output : Jane jdoe@example.com # TODO known breakage
#   Failed (TODO) test 'same output : Jane jdoe@example.com'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane'
#     $expected->[0] = 'Janejdoe@example.com'
not ok 30 - same output : <jdoe@example.com> Jane Doe # TODO known breakage
#   Failed (TODO) test 'same output : <jdoe@example.com> Jane Doe'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane Doe <jdoe@example.com>'
#     $expected->[0] = 'jdoe@example.comJaneDoe'
not ok 31 - same output : Jane <jdoe@example.com> Doe # TODO known breakage
#   Failed (TODO) test 'same output : Jane <jdoe@example.com> Doe'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane Doe <jdoe@example.com>'
#     $expected->[0] = 'Jane <jdoe@example.comDoe>'
not ok 32 - same output : "Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : "Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com>'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '"Jane " Kat "a" ri "na" ",Doe" <jdoe@example.com>'
#     $expected->[0] = '"Jane  Kat a ri na ,Doe" <jdoe@example.com>'
not ok 33 - same output : Jane Doe # TODO known breakage
#   Failed (TODO) test 'same output : Jane Doe'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane'
#     $expected->[0] = 'Jane Doe'
not ok 34 - same output : Jane "Doe <jdoe@example.com>" # TODO known breakage
#   Failed (TODO) test 'same output : Jane "Doe <jdoe@example.com>"'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane'
#     $expected->[0] = '"Jane Doe <jdoe@example.com>"'
not ok 35 - same output : \"Jane Doe <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : \"Jane Doe <jdoe@example.com>'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = '\ " Jane Doe <jdoe@example.com>'
#     $expected->[0] = '"\"Jane Doe" <jdoe@example.com>'
not ok 36 - same output : Jane\"\" Doe <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : Jane\"\" Doe <jdoe@example.com>'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = 'Jane \ " \ " Doe <jdoe@example.com>'
#     $expected->[0] = '"Jane\"\" Doe" <jdoe@example.com>'
not ok 37 - same output : 'Jane "Katarina\" \' Doe' <jdoe@example.com> # TODO known breakage
#   Failed (TODO) test 'same output : 'Jane "Katarina\" \' Doe' <jdoe@example.com>'
#   at /Users/me/projects/git/git.pu/t/t9000/test.pl line 62.
#     Structures begin differing at:
#          $got->[0] = ''Jane " Katarina \ " \ ' Doe' <jdoe@example.com>'
#     $expected->[0] = '"'Jane  Katarina\" \' Doe'" <jdoe@example.com>'
1..37
# test_external test Perl address parsing function failed: perl /Users/me/projects/git/git.pu/t/t9000/test.pl
# expecting no stderr from previous command
# test_external_without_stderr test no stderr: Perl address parsing function failed: perl /Users/me/projects/git/git.pu/t/t9000/test.pl: 
# Stderr is:
Can't locate object method "is_passing" via package "Test::Builder" at /Users/me/projects/git/git.pu/t/t9000/test.pl line 66.
# Looks like your test died just after 37.
