From: Marios Titas <redneb@gmx.com>
Subject: Re: [PATCH 2/2] ident: make the useConfigOnly error messages more
 informative
Date: Thu, 31 Mar 2016 02:25:52 +0300
Message-ID: <20160330232552.GA31861@zeno>
References: <1459366183-15451-1-git-send-email-redneb@gmx.com>
 <1459366183-15451-2-git-send-email-redneb@gmx.com>
 <xmqqlh4zr492.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 01:26:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alPV8-0004SO-Iw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 01:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbcC3X0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 19:26:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:53466 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154AbcC3X0F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 19:26:05 -0400
Received: from localhost.localdomain ([79.103.155.63]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0M54L0-1ZnZ5H0c5G-00zG3M; Thu, 31 Mar
 2016 01:25:57 +0200
Content-Disposition: inline
In-Reply-To: <xmqqlh4zr492.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Provags-ID: V03:K0:IKCXSbIjsk9LzZi8rokAeI3Ve8LqASWagZhr2chGloso5pfB0fB
 5cAcuECyTtzA9O0nLa/PMNkppib4VgcGy6ftu5jgJmw40XLNym3nJ6iMzYRgPNSVFN6xF1v
 2gtoWwFtuulviB1uVSZwkB8XBIuDsSXD9LL0q4HnUHZSpunylTYQoAgxYI1GN8yjebwJ5KL
 OKOJc/0pAV6BUcgS0xIKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EpWrUR/mnT4=:ibcvZCzmZxZZRW7gr9hMKk
 AS7arnU5fNjlluJMEzEfCw/RFvNeHs9xKvfZiGFvibpfD5MDEr6EAmTm3lgtZXlMat6u5VMGH
 iUV6n04rlzTr2KZXOnqvdGkHsB9/ktx+tHuLdQ4Hi8vPZUtotFTxtJ/CiTprNDcOnbDZQyJ85
 eVb9ac7TlrZ93wTSWuaSZ8b0QHxrfOXVSSlErqLOYcjHRF+Hf5EidL20VG76ePdbPzXG51Vuq
 594CFFPvacilzW2dZ/sCVwFDJ2ZE8xqcCaUiNkblBShTW03ZpVp0A/rY/HiiRlmAHM4E93LTi
 Qu6CgJd2mD1KWw7BSgr5+sjzQwA74dGP8U5MHXJ250havYFaiOe217YfZ0lIapH5H3xwENXEN
 YJwaiaOGiS0IK6Z+KVFQiay22gi9ACg73dWWWCJIrvBkoxWKnf7USIorrKS8ZXfWoIUbFBg2A
 ToctnPugBjAq9IMsm3wcI2WMyqbRHYyIyYHxNOFAwVfryMtM0M0I4O+1pGm+3s2bhDBD/CAof
 tn7DDhH2mbkKIJhNr40gRJxYa1YEp7IOFoEHjNGO29SwsqWQ3wepF0ZoDwPUyFGxUlHDirj0G
 +WHOTFxDH/VY8VA+Fx78xvU4eI6oy6IpOviY3jGvhrXUtTiNcHbdIasBLVN50/P29XfNrj9Sw
 0bXFeXJ4dgDQZ+8kdowQzXBTB6smMqppcgywilsJZQfFwDejKuTUwOtz4G7cWMv09Skf9cRam
 V/MuXi4lalavDnmPjih9sHt1g17wxDFfGu7Xj715kPqcYhifukmlsxStJok=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290356>

On Wed, Mar 30, 2016 at 03:27:05PM -0700, Junio C Hamano wrote:
>Marios Titas <redneb@gmx.com> writes:
>
>> -			    && !(ident_config_given & IDENT_NAME_GIVEN))
>> -				die("user.useConfigOnly set but no name given");
>> +			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
>> +				fputs(env_hint, stderr);
>> +				die("no name was given and auto-detection is disabled
>
>Hmph.  I do not think that this is making the message "more
>informative".
>
>When a user hits this error, the old message allowed the user to
>easily see how to toggle the "disable auto-detection" bit off to let
>the code continue by telling the name of the configuration, but the
>updated message hides that name, making it harder for the user to
>disable the disabling of auto-detection.
>
>I can buy the argument that this change helps the user by making the
>message "less" informative, though.  By discouraging the users from
>toggling the user.useConfigOnly bit off, it indirectly makes the
>other option to work around this error condition, i.e. giving a name
>more explicitly, more appetizing.

Yeah, maybe informative is not the right word. What I meant is that it 
directs the user to do the "git config user.name" thing, which is likely 
the most appropriate course of action in this situation. In any event, I 
think printing the env_hint message would be really helpful in this 
case.
