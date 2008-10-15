From: Christian Jaeger <christian@pflanze.mine.nu>
Subject: Re: Separating generated files?
Date: Wed, 15 Oct 2008 18:45:56 +0200
Message-ID: <48F61E44.3080900@pflanze.mine.nu>
References: <E6D34628-783D-4597-8B00-C10F27F63BE2@iro.umontreal.ca>	<48F5D86B.6040501@pflanze.mine.nu>	<fcaeb9bf0810150754s613f2c44pd8341711d9d73f73@mail.gmail.com>
	<vpqiqrt3mgs.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Gambit List <Gambit-list@iro.umontreal.ca>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: gambit-list-bounces@iro.umontreal.ca Wed Oct 15 18:47:52 2008
Return-path: <gambit-list-bounces@iro.umontreal.ca>
Envelope-to: glsg-gambit-list@m.gmane.org
Received: from mercure.iro.umontreal.ca ([132.204.24.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq9X8-0008J1-ST
	for glsg-gambit-list@m.gmane.org; Wed, 15 Oct 2008 18:47:39 +0200
Received: from mercure.iro.umontreal.ca (localhost.iro.umontreal.ca [127.0.0.1])
	by mercure.iro.umontreal.ca (Postfix) with ESMTP id 098CC2CFD81;
	Wed, 15 Oct 2008 12:46:29 -0400 (EDT)
X-Original-To: gambit-list@iro.umontreal.ca
Delivered-To: gambit-list@iro.umontreal.ca
Received: from perlin.iro.umontreal.ca (perlin.iro.umontreal.ca
	[132.204.24.51])
	by mercure.iro.umontreal.ca (Postfix) with ESMTP id 5D7162CFD7B
	for <gambit-list@iro.umontreal.ca>;
	Wed, 15 Oct 2008 12:46:27 -0400 (EDT)
Received: from ethlife.ethz.ch (ethlife-a.ethz.ch [129.132.49.178])
	by perlin.iro.umontreal.ca (Postfix) with SMTP id 562A1148229
	for <Gambit-list@iro.umontreal.ca>;
	Wed, 15 Oct 2008 12:45:58 -0400 (EDT)
Received: (qmail 26216 invoked from network); 15 Oct 2008 16:45:57 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
	by localhost with SMTP; 15 Oct 2008 16:45:57 -0000
Received: (qmail 6757 invoked from network); 15 Oct 2008 16:45:57 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
	by elvis-jaeger.mine.nu with SMTP; 15 Oct 2008 16:45:57 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <vpqiqrt3mgs.fsf@bauges.imag.fr>
X-DIRO-MailScanner-Information: Please contact the ISP for more information
X-DIRO-MailScanner: Found to be clean
X-DIRO-MailScanner-SpamCheck: n'est pas un polluriel,
	SpamAssassin (score=-2.599, requis 5, BAYES_00 -2.60)
X-DIRO-MailScanner-From: christian@pflanze.mine.nu
X-Spam-Status: No
X-BeenThere: gambit-list@iro.umontreal.ca
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: Discussion of topics related to the use of the Gambit Scheme system
	<gambit-list.iro.umontreal.ca>
List-Unsubscribe: <https://webmail.iro.umontreal.ca/mailman/listinfo/gambit-list>,
	<mailto:gambit-list-request@iro.umontreal.ca?subject=unsubscribe>
List-Archive: <http://webmail.iro.umontreal.ca/pipermail/gambit-list>
List-Post: <mailto:gambit-list@iro.umontreal.ca>
List-Help: <mailto:gambit-list-request@iro.umontreal.ca?subject=help>
List-Subscribe: <https://webmail.iro.umontreal.ca/mailman/listinfo/gambit-list>,
	<mailto:gambit-list-request@iro.umontreal.ca?subject=subscribe>
Sender: gambit-list-bounces@iro.umontreal.ca
Errors-To: gambit-list-bounces@iro.umontreal.ca
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98286>

Matthieu Moy wrote:
> I think the first question is: do you (and why) need to use a version
> control system for generated files?

The project in question is a self-hosting compiler which compiles to C 
as an intermediary language. Providing the generated C files to users 
makes installation easy (it avoids the bootstrapping issue). So it's 
more 'severe' of an issue than just one of for example generating 
documentation files using a 3rd-party tool.

What may make matters worse, is that there are interdependencies between 
a number of hand-written C files and the generated files, so it's not 
always possible to use an older compiler version to reproduce the 
generated C files for a newer compiler; so if you want to merge newer 
compiler sources, you may also need the generated files, at least if you 
want that without fuss. So, there is always a need to somehow transmit 
the generated files too. I guess that this is easier than code the 
system in a way to always allow backwards compatibility (I haven't 
worked on the compiler itself yet, so this is a guess and may need 
confirmation).

Apart from that, I've found it useful (in another project, writing a 
document translator) to keep generated files in a VCS (Git) as well (I 
checked them into the *same* repository as the translator source, even 
if it felt ugly (for the previously mentioned reasons)), as then when I 
changed the translator, I could easily see where it had effect on the 
generated output. It can even serve as a debugging help kind of like a 
test suite does. This may be the case here, too (again, I'm guessing here).

How are other compiler projects which are bootstrapping via C dealing 
with this?

Christian.
