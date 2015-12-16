From: Sam Hocevar <sam@hocevar.net>
Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Date: Wed, 16 Dec 2015 01:38:34 +0100
Message-ID: <20151216003834.GG48528@hocevar.net>
References: <1450037234-15344-1-git-send-email-luke@diamand.org>
 <CAE5ih7_T1xC9AyO41T4ktJmj6tENaEGbAG556WLyfsYz-jawsw@mail.gmail.com>
 <xmqqio40kfhl.fsf@gitster.mtv.corp.google.com>
 <CAE5ih7_9m8kw=sVj8Sv5mAfT_22-g0vdTb78FvLTrNUkJO0M0g@mail.gmail.com>
 <xmqqtwnkhegw.fsf@gitster.mtv.corp.google.com>
 <CAE5ih7_qY5oF+UWs4gE2eHUu17pBg6TVGTUyRRRcBe12ybkw+Q@mail.gmail.com>
 <1450220213834.32062@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: James Farwell <jfarwell@vmware.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 01:38:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a907D-0007hX-Qi
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933844AbbLPAim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:38:42 -0500
Received: from poulet.zoy.org ([193.200.42.166]:56343 "EHLO smtp.zoy.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932992AbbLPAil (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:38:41 -0500
Received: by smtp.zoy.org (Postfix, from userid 1000)
	id 507D136126C; Wed, 16 Dec 2015 01:38:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1450220213834.32062@vmware.com>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282524>

   I'm actually surprised that the patch changes the order at all, since
all it does is affect the decision (on a yes/no basis) to include a given
file into a changelist. I'm going to have a look at that specific unit
test, but of course as a user I'd prefer if the default behaviour could
remain the same, unless it was actually a bug.

-- 
Sam.

On Tue, Dec 15, 2015, James Farwell wrote:
> I'm not sure if my opinion as an outsider is of use, but since the perforce change number is monotonically increasing, my expectation as a user would be for them to be applied in order by the perforce change number. :)
> 
> - James
> 
> ________________________________________
> From: Luke Diamand <luke@diamand.org>
> Sent: Monday, December 14, 2015 3:09 PM
> To: Junio C Hamano
> Cc: Git Users; James Farwell; Lars Schneider; Eric Sunshine; Sam Hocevar
> Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
> 
> Sorry - I've just run the tests, and this change causes one of the
> test cases in t9800-git-p4-basic.sh to fail.
> 
> It looks like the test case makes an assumption about who wins if two
> P4 depots have changes to files that end up in the same place, and
> this change reverses the order. It may actually be fine, but it needs
> to be thought about a bit.
> 
> Sam - do you have any thoughts on this?
> 
> Thanks
> Luke
> 
> 
> 
> 
> 
> 
> On 14 December 2015 at 22:06, Junio C Hamano <gitster@pobox.com> wrote:
> > Luke Diamand <luke@diamand.org> writes:
> >
> >> On 14 December 2015 at 19:16, Junio C Hamano <gitster@pobox.com> wrote:
> >>> Luke Diamand <luke@diamand.org> writes:
> >>>
> >>>> Having just fixed this, I've now just spotted that Sam Hocevar's fix
> >>>> to reduce the number of P4 transactions also fixes it:
> >>>>
> >>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__www.mail-2Darchive.com_git-2540vger.kernel.org_msg81880.html&d=BQIBaQ&c=Sqcl0Ez6M0X8aeM67LKIiDJAXVeAw-YihVMNtXt-uEs&r=wkCayFhpIBdAOEa7tZDTcd1weqwtiFMEIQTL-WQPwC4&m=q8dsOAHvUiDzzPNGRAfMMrcXstxNlI-v7I_03uEL1e8&s=C8wVLMC-iU7We0r36sxOuu920ZjZYdpy7ysNi_5PYv8&e=
> >>>>
> >>>> That seems like a cleaner fix.
> >>>
> >>> Hmm, do you mean I should ignore this series and take the other one,
> >>> take only 1/2 from this for tests and then both patches in the other
> >>> one, or something else?
> >>
> >> The second of those (take only 1/2 from this for tests, and then both
> >> from the other) seems like the way to go.
> >
> > OK.  Should I consider the two patches from Sam "Reviewed-by" you?
echo "creationism" | tr -d "holy godly goal"
