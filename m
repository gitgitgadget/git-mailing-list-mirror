From: =?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 23 Jan 2013 13:34:00 -0500
Message-ID: <51002D18.4080201@calculquebec.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil> <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com> <87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org> <87r4lejpx8.fsf@pctrast.inf.ethz.ch> <50FF051D.5090804@giref.ulaval.ca> <878v7keuh3.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------020402090603000403060209"
Cc: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, <git@vger.kernel.org>,
	<kusmabite@gmail.com>,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 23 19:40:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty5FT-0006Vm-9h
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 19:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929Ab3AWSkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 13:40:13 -0500
Received: from mail.chuq.qc.ca ([132.203.232.94]:50300 "EHLO mail.chuq.qc.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab3AWSkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 13:40:12 -0500
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2013 13:40:11 EST
Received: from [192.168.128.180] (132.203.117.4) by webmail.chuq.qc.ca
 (132.203.232.94) with Microsoft SMTP Server id 14.1.355.2; Wed, 23 Jan 2013
 13:34:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <878v7keuh3.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214342>

--------------020402090603000403060209
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Here is a patch (with git format-patch) that removes any timer if NO_SETITIMER is set.


Éric:

To test it with your workflow:

$ module load apps/git/1.8.1.1.348.g78eb407-NO_SETITIMER-patch

$ git clone ...


                               Sébastien


On 01/22/2013 05:14 PM, Thomas Rast wrote:
> Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:
>
>> So, hum, do we have some sort of conclusion?
>>
>> Shall it be a fix for git to get around that lustre "behavior"?
>>
>> If something can be done in git it would be great: it is a *lot*
>> easier to change git than the lustre filesystem software for a cluster
>> in running in production mode... (words from cluster team) :-/
>
> I thought you already established that simply disabling the progress
> display is a sufficient workaround?  If that doesn't help, you can try
> patching out all use of SIGALRM within git.
>
> Other than that I agree with Junio, from what we've seen so far, Lustre
> returns EINTR on all sorts of calls that simply aren't allowed to do so.
>


-- 
---
Spécialiste en granularité (1 journée / semaine)
Calcul Québec / Calcul Canada
Pavillon Adrien-Pouliot, Université Laval, Québec (Québec), Canada

--------------020402090603000403060209
Content-Type: text/x-patch;
	name="0001-don-t-use-timers-if-NO_SETITIMER-is-set.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-don-t-use-timers-if-NO_SETITIMER-is-set.patch"

>From 78eb4075d98eb9cdc57210c63b8d8de8a3d0cd9e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?S=C3=A9bastien=20Boisvert?= <sebastien.boisvert@calculquebec.ca>
Date: Wed, 23 Jan 2013 13:10:57 -0500
Subject: [PATCH] don't use timers if NO_SETITIMER is set
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With NO_SETITIMER, the user experience on legacy Lustre is fixed,
but there is no early progress.

The patch has no effect on the resulting git executable if NO_SETITIMER is
not set (the default). So by default this patch has no effect at all, which
is good.

git tests:

$ make clean
$ make NO_SETITIMER=YesPlease
$ make test NO_SETITIMER=YesPlease &> make-test.log

$ grep "^not ok" make-test.log |grep -v "# TODO known breakage"|wc -l
0
$ grep "^ok" make-test.log |wc -l
9531
$ grep "^not ok" make-test.log |wc -l
65

No timers with NO_SETITIMER:

$ objdump -d ./git|grep setitimer|wc -l
0
$ objdump -d ./git|grep alarm|wc -l
0

Timers without NO_SETITIMER:

$ objdump -d /software/apps/git/1.8.1/bin/git|grep setitimer|wc -l
5
$ objdump -d /software/apps/git/1.8.1/bin/git|grep alarm|wc -l
0

Signed-off-by: SÃ©bastien Boisvert <sebastien.boisvert@calculquebec.ca>
---
 builtin/log.c |    7 +++++++
 daemon.c      |    6 ++++++
 progress.c    |    8 ++++++++
 upload-pack.c |    2 ++
 4 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..f8321c7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -198,7 +198,9 @@ static void show_early_header(struct rev_info *rev, const char *stage, int nr)
 	printf(_("Final output: %d %s\n"), nr, stage);
 }
 
+#ifndef NO_SETITIMER
 static struct itimerval early_output_timer;
+#endif
 
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
@@ -240,9 +242,12 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 	 * trigger every second even if we're blocked on a
 	 * reader!
 	 */
+
+	#ifndef NO_SETITIMER
 	early_output_timer.it_value.tv_sec = 0;
 	early_output_timer.it_value.tv_usec = 500000;
 	setitimer(ITIMER_REAL, &early_output_timer, NULL);
+	#endif
 }
 
 static void early_output(int signal)
@@ -274,9 +279,11 @@ static void setup_early_output(struct rev_info *rev)
 	 *
 	 * This is a one-time-only trigger.
 	 */
+	#ifndef NO_SETITIMER
 	early_output_timer.it_value.tv_sec = 0;
 	early_output_timer.it_value.tv_usec = 100000;
 	setitimer(ITIMER_REAL, &early_output_timer, NULL);
+	#endif
 }
 
 static void finish_early_output(struct rev_info *rev)
diff --git a/daemon.c b/daemon.c
index 4602b46..eb82c19 100644
--- a/daemon.c
+++ b/daemon.c
@@ -611,9 +611,15 @@ static int execute(void)
 	if (addr)
 		loginfo("Connection from %s:%s", addr, port);
 
+	#ifndef NO_SETITIMER
 	alarm(init_timeout ? init_timeout : timeout);
+	#endif
+
 	pktlen = packet_read_line(0, line, sizeof(line));
+
+	#ifndef NO_SETITIMER
 	alarm(0);
+	#endif
 
 	len = strlen(line);
 	if (pktlen != len)
diff --git a/progress.c b/progress.c
index 3971f49..b84ccc7 100644
--- a/progress.c
+++ b/progress.c
@@ -45,7 +45,10 @@ static void progress_interval(int signum)
 static void set_progress_signal(void)
 {
 	struct sigaction sa;
+
+	#ifndef NO_SETITIMER
 	struct itimerval v;
+	#endif
 
 	progress_update = 0;
 
@@ -55,16 +58,21 @@ static void set_progress_signal(void)
 	sa.sa_flags = SA_RESTART;
 	sigaction(SIGALRM, &sa, NULL);
 
+	#ifndef NO_SETITIMER
 	v.it_interval.tv_sec = 1;
 	v.it_interval.tv_usec = 0;
 	v.it_value = v.it_interval;
 	setitimer(ITIMER_REAL, &v, NULL);
+	#endif
 }
 
 static void clear_progress_signal(void)
 {
+	#ifndef NO_SETITIMER
 	struct itimerval v = {{0,},};
 	setitimer(ITIMER_REAL, &v, NULL);
+	#endif
+
 	signal(SIGALRM, SIG_IGN);
 	progress_update = 0;
 }
diff --git a/upload-pack.c b/upload-pack.c
index 95d8313..e0b8b32 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -47,7 +47,9 @@ static int stateless_rpc;
 
 static void reset_timeout(void)
 {
+	#ifndef NO_SETITIMER
 	alarm(timeout);
+	#endif
 }
 
 static int strip(char *line, int len)
-- 
1.7.4.1


--------------020402090603000403060209--
